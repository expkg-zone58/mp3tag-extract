(:~
 : test mp3 tag extraction
 :)
import module namespace mp3agic = "expkg-zone58.audio.mp3" at "../main/content/mp3magic.xqm";

declare namespace Mp3File="java:com.mpatric.mp3agic.Mp3File";
declare variable $f:="v24tagswithalbumimage.mp3";
 
let $f:=file:resolve-path($f,file:base-dir() )
let $mp3:=Mp3File:new($f)
let $x:=<mp3><length>{Mp3File:getSampleRate($mp3)}</length></mp3>
return  mp3agic:detail($f) 