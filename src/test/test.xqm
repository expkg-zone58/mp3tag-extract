(:~
 : unit tests for metadata module
 :)
module namespace test = 'http://basex.org/modules/xqunit-tests'; 

import module namespace metadata = "expkg-zone58:audio.metadata" at "../main/content/audiotagger.xqm";
declare variable $test:base:=file:resolve-path("resources/",static-base-uri());

declare variable $test:mp3:=file:resolve-path("v24tagswithalbumimage.mp3",$test:base );
 
(:~ we get tags :)
declare
  %unit:test
  function test:read() {
  let $meta:=metadata:read($test:mp3)
  return unit:assert($meta/tag)
};
(:~ we get art :)
declare
  %unit:test
  function test:artwork() {
  let $map:=metadata:artwork($test:mp3)
  return unit:assert($map?binaryData instance of xs:base64Binary)
};  
