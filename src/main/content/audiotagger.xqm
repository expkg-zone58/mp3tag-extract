xquery version "3.0";
(:~
: Extract audio tags using the  <a href="https://bitbucket.org/ijabz/jaudiotagger">jaudiotagger</a> library.
: jaudiotagger supports Mp3, Mp4 (Mp4 audio, M4a and M4p audio) Ogg Vorbis, Flac and Wma, 
: there is  limited support for Wav and Real formats.
: @see https://bitbucket.org/ijabz/jaudiotagger
:
: @author andy bunce
: @version 0.7.1
: @licence apache 2
:)
 
module namespace audiometa = 'expkg-zone58:audio.metadata';
declare namespace MP3File="java:org.jaudiotagger.audio.mp3.MP3File";
declare namespace FieldKey="java:org.jaudiotagger.tag.FieldKey";
declare namespace Tag="java:org.jaudiotagger.tag.Tag";
declare namespace TagTextField="java:org.jaudiotagger.tag.TagTextField";
declare namespace list="java:java.util.List";

declare %private variable $audiometa:names:=FieldKey:values();

(:~
 : Get tag details from audio file  trapping all errors.
 : @param $file filepath of audio file
 : @return <code>&lt;metadata src=".."&gt;&lt;tag&gt;..</code>
 :)
declare function audiometa:read($file as xs:string) 
as element(metadata)
{
   <metadata src="{$file}">{
    try{
           audiometa:extract($file)
      } catch *{
           <error code="{$err:code}">{$err:description}</error> 
    }
    }</metadata>
};

(:~
 : Get tag details from audio file as a sequence.
 : @param $file filepath of audio file
 : @return <code>&lt;tag dir=".." name=".."&gt;value&lt;tag....</code>
 :)
declare function audiometa:extract($file as xs:string) 
as element()*
{
  let $a:=MP3File:new($file)
  let $tag:= MP3File:getTag($a)
  let $fn:=audiometa:style-a(?,?,"ID3")
  return $audiometa:names!audiometa:getFields(.,$tag,$fn )
};

declare %private function audiometa:getFields($name ,$tag,
                                $f as function(xs:string,xs:string) as element()) 
as element()*
{
  if(Tag:hasField($tag,$name))
  then let $tf:=Tag:getFields($tag,$name)
       for $i in 0 to list:size($tf)-1
       let $i0:=list:get($tf,xs:int($i))
       let $v:=(# db:checkstrings false #){audiometa:clean-string(TagTextField:getContent($i0))}
       return $f(string($name),$v)
  else ()
};


declare  %private function audiometa:style-a($name as xs:string,$value as xs:string,$dir as xs:string) 
as element(tag)
{
  <tag dir="{$dir}" name="{$name}">{$value}</tag>
};

(:~ remove bad chars from java string
 : need more eg [^\x09\x0A\x0D\x20-\uD7FF\uE000-\uFFFD\u10000-u10FFFF]
 : @see http://stackoverflow.com/a/14323524
 :)
declare %private function audiometa:clean-string($s)
as xs:string
{
    let $t:= fn:string-to-codepoints($s)
    let $t:=fn:filter($t,function($c as xs:integer){$c > 8})
    return fn:codepoints-to-string($t)
};