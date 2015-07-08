xquery version "3.0";
(:~
: Extract mp3 tags using mp3agic 
: @see https://github.com/mpatric/mp3agic
:
: @author andy bunce
: @since mar 2015
: @licence apache 2
:)
 
module namespace mp3agic = 'expkg-zone58.audio.mp3';
declare default function namespace 'expkg-zone58.audio.mp3';

declare namespace Mp3File="java:com.mpatric.mp3agic.Mp3File";
declare namespace ID3v1Tag="java:com.mpatric.mp3agic.ID3v1Tag";
declare namespace ID3v2Tag="java:com.mpatric.mp3agic.ID3v2";

declare variable $mp3agic:v0:=map{
  "length":Mp3File:getLengthInSeconds#1,
   "samplerate":Mp3File:getSampleRate#1,
    "version":Mp3File:getVersion#1,
    "layer":Mp3File:getLayer#1,
    "bitrate":Mp3File:getBitrate#1,
    "isVbr":Mp3File:isVbr#1, 
    "channelmode":Mp3File:getChannelMode#1
};

declare variable $mp3agic:v1tags:=map{
  "artist":ID3v1Tag:getArtist#1,
   "album":ID3v1Tag:getAlbum#1,
   "track":ID3v1Tag:getTrack#1,
   "title":ID3v1Tag:getTitle#1
};

declare variable $mp3agic:v2tags:=map{
  "artist":ID3v2Tag:getArtist#1,
   "album":ID3v2Tag:getAlbum#1,
   "track":ID3v2Tag:getTrack#1,
   "title":ID3v2Tag:getTitle#1,
   "year":ID3v2Tag:getYear#1,
   "genre":ID3v2Tag:getGenre#1,
    "genredescription":ID3v2Tag:getGenreDescription#1,
    "comment":ID3v2Tag:getComment#1,
    "composer":ID3v2Tag:getComposer#1,
    "publisher":ID3v2Tag:getPublisher#1,
    "originalartist":ID3v2Tag:getOriginalArtist#1,
    "albumartist":ID3v2Tag:getAlbumArtist#1,
    "copyright":ID3v2Tag:getCopyright#1,
    "url":ID3v2Tag:getUrl#1,
    "encoder":ID3v2Tag:getEncoder#1
};

declare variable $mp3agic:dirs:=map{
  "file":$mp3agic:v0,
  "Id3v1":$mp3agic:v1tags,
  "Id3v2": $mp3agic:v2tags
};

(:~
 : tag details from file name trapping all errors
 :)
declare function read($f as xs:string) as element(metadata)
{
   <metadata src="{$f}">{
    try{
    tags($f)
      } catch *{
      <error code="{$err:code}">{$err:description}</error> 
    }
    }</metadata>
};

declare function tags($file as xs:string) as element(tag)*
{
    let $mp3:=Mp3File:new($file)
    return (extract-tags($mp3agic:v0,$mp3,"file"),
            id3v1Tag($mp3),
            id3v2Tag($mp3)
            )
};

declare function id3v1Tag($mp3) as element(tag)*
{
   if(Mp3File:hasId3v1Tag($mp3)) then
       let $id3v1:=Mp3File:getId3v1Tag($mp3)
       return extract-tags($mp3agic:v1tags,$id3v1,"Id3v1")    
   else  ()
};

declare function id3v2Tag($mp3)  as element(tag)*
{
   if(Mp3File:hasId3v2Tag($mp3)) then 
     let $id3v2:=Mp3File:getId3v2Tag($mp3)
     return  extract-tags($mp3agic:v2tags,$id3v2,"Id3v2")
   else () 
};

(:~ 
 : if $src has tag extractable using $fn return as element
:)
declare %private function extract-tag($src,
                                      $dir as xs:string,
                                      $name as xs:string,
                                      $fn) as element(tag)?
{
    let $v:=$fn($src)
    return if($v) then element tag {
                                  attribute dir {$dir},
                                  attribute name {$name},
                                   $v
                                 } else ()
};

declare %private function extract-tags($map,$src,
                                    $dir as xs:string) as element()*
{
 map:for-each($map,function($n,$f){extract-tag($src,$dir,$n,$f)})
};

