xquery version "3.0";
(:~
: Extract mp3 tags using jaudiotagger 
: @see https://bitbucket.org/ijabz/jaudiotagger
:
: @author andy bunce
: @since june 2016
: @licence apache 2
:)
 
module namespace tags = 'expkg-zone58.metadata.audio';
declare namespace MP3File="java:org.jaudiotagger.audio.mp3.MP3File";
declare namespace FieldKey="java:org.jaudiotagger.tag.FieldKey";
declare namespace Tag="java:org.jaudiotagger.tag.Tag";
declare namespace TagTextField="java:org.jaudiotagger.tag.TagTextField";
declare namespace list="java:java.util.List";
declare variable $tags:names:=FieldKey:values();

(:~
 : tag details from file name trapping all errors
 :)
declare function tags:read($f as xs:string) as element(metadata)
{
   <metadata src="{$f}">{
    try{
    tags:extract($f)
      } catch *{
      <error code="{$err:code}">{$err:description}</error> 
    }
    }</metadata>
};

declare function tags:extract($f as xs:string) as element()*
{
  let $a:=MP3File:new($f)
  let $tag:= MP3File:getTag($a)
  let $f:=tags:style-a(?,?,"ID3")
  return $tags:names!tags:getFields(.,$tag,$f )
};

declare function tags:getFields($name ,$tag,
                                $f as function(xs:string,xs:string) as element()) as element()*
{
  if(Tag:hasField($tag,$name))
  then let $tf:=Tag:getFields($tag,$name)
       for $i in 0 to list:size($tf)-1
       let $i0:=list:get($tf,xs:int($i))
       return $f(string($name),TagTextField:getContent($i0))
  else ()
};

declare function tags:style-e($name as xs:string,$value as xs:string) as element()
{
  element {$name} { $value}
};
declare function tags:style-a($name as xs:string,$value as xs:string,$dir as xs:string) as element()
{
  <tag dir="{$dir}" name="{$name}">{$value}</tag>
};