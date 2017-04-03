xquery version "3.1";
(:~
: Extract audio tags using the  <a href="https://bitbucket.org/ijabz/jaudiotagger">jaudiotagger</a> library.
: jaudiotagger supports Mp3, Mp4 (Mp4 audio, M4a and M4p audio) Ogg Vorbis, Flac and Wma, 
: there is  limited support for Wav and Real formats.
: @see https://bitbucket.org/ijabz/jaudiotagger
:
: @author andy bunce
: @version 0.8.2
: @licence apache 2
:)
 
module namespace audiometa = 'expkg-zone58:audio.metadata';
declare namespace MP3File="java:org.jaudiotagger.audio.mp3.MP3File";
declare namespace FieldKey="java:org.jaudiotagger.tag.FieldKey";
declare namespace Tag="java:org.jaudiotagger.tag.Tag";
declare namespace TagTextField="java:org.jaudiotagger.tag.TagTextField";
declare namespace StandardArtwork="org.jaudiotagger.tag.images.StandardArtwork";

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
           audiometa:tags($file)
      } catch *{
           <error code="{$err:code}">{$err:description}</error> 
    }
    }</metadata>
};

(:~
 : Get tag details from audio file as a sequence of <code>tag</code> elements.
 : @param $file filepath of the audio file to process.
 : @return <code>&lt;tag dir=".." name=".."&gt;value&lt;tag....</code>
 :)
declare function audiometa:tags($file as xs:string) 
as element(tag)*
{
  let $a:=MP3File:new($file)
  let $tag:= MP3File:getTag($a)
  let $fn:=audiometa:style-a(?,?,"ID3")
  return $audiometa:names!audiometa:getFields(.,$tag,$fn )
};

(:~
 : Get artwork.
 : @param $file filepath of the audio file to process.
 : @param $index of artwork to return
 : @return map containing binaryData as xs:base64Binary, "mimeType" as xs:string
 :)
declare function audiometa:artwork($file as xs:string,$index as xs:integer)
as map(*) 
{
  let $a:=MP3File:new($file)
  let $tag:= MP3File:getTag($a)
  let $artlist:= Tag:getArtworkList($tag)
  let $art:=if($index lt 0 or $index ge list:size($artlist)) then
                fn:error(xs:QName("audiometa:artindex"),"Artwork index error")
            else
               list:get($artlist,xs:int($index)) 
  return map{ 
    "mimeType":StandardArtwork:getMimeType($art),
    "binaryData":StandardArtwork:getBinaryData($art)=> convert:bytes-to-base64()
  }
};

(:~
 : Get first artwork.
 : @param $file filepath of the audio file to process.
 : @return map containing binaryData as xs:base64Binary, "mimeType" as xs:string
 :)
declare function audiometa:artwork($file as xs:string)
as map(*)
{
    audiometa:artwork($file ,0)
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