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
declare namespace ID3Wrapper="java:com.mpatric.mp3agic.ID3Wrapper";

declare variable $mp3agic:v0:=map{
    "Length":Mp3File:getLengthInSeconds#1,
    "SampleRate":Mp3File:getSampleRate#1,
    "Version":Mp3File:getVersion#1,
    "Layer":Mp3File:getLayer#1,
    "Bitrate":Mp3File:getBitrate#1,
    "isVbr":Mp3File:isVbr#1, 
    "ChannelMode":Mp3File:getChannelMode#1
};

declare variable $mp3agic:id3tags:=map{
    "Artist":ID3Wrapper:getArtist#1,
    "Album":ID3Wrapper:getAlbum#1,
    "Track":ID3Wrapper:getTrack#1,
    "Title":ID3Wrapper:getTitle#1,
    "Year":ID3Wrapper:getYear#1,
    "GenreDescription":ID3Wrapper:getGenreDescription#1,
    "Comment":ID3Wrapper:getComment#1,
    "Composer":ID3Wrapper:getComposer#1,
    "OriginalArtist":ID3Wrapper:getOriginalArtist#1,
    "Copyright":ID3Wrapper:getCopyright#1,
    "Url":ID3Wrapper:getUrl#1,
    "Encoder":ID3Wrapper:getEncoder#1,
    "AlbumImageMimeType":ID3Wrapper:getAlbumImageMimeType#1
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
    return (extract-tags( $mp3agic:v0,$mp3,"file"),
            id3Tags($mp3)
            )
};

(:~ 
  : @return standard id3 tags 
 :)
declare function id3Tags($mp3) as element(tag)*
{
  let $id3v1:=Mp3File:getId3v1Tag($mp3)
  let $id3v2:=Mp3File:getId3v2Tag($mp3)
	let $id3wrapper := ID3Wrapper:new($id3v1, $id3v2)
  
  return extract-tags($mp3agic:id3tags,$id3wrapper,"Id3") 
};

(:~ 
  : @return standard id3 tags 
 :)
declare function AlbumImage($mp3) as xs:hexBinary?
{
  let $id3v2:=Mp3File:getId3v2Tag($mp3)
  return convert:bytes-to-hex(ID3v2Tag:getAlbumImage($id3v2))
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
                                   fn:trace($v)
                                 } else ()
};

declare %private function extract-tags($map,$src,
                                    $dir as xs:string) as element()*
{
 map:for-each($map,function($n,$f){extract-tag($src,$dir,$n,$f)})
};

