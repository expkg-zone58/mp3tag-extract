(:~
 : unit tests for metadata module
 :)
module namespace test = 'http://basex.org/modules/xqunit-tests'; 

import module namespace metadata = "expkg-zone58.metadata.audio" at "../main/content/audiotagger.xqm";
declare variable $test:base:=file:resolve-path("resources/",static-base-uri());

declare variable $test:mp3:=file:resolve-path("v24tagswithalbumimage.mp3",$test:base );
 
(:~ we get tags :)
declare
  %unit:test
  function test:success-function() {
  let $meta:=metadata:read($test:mp3)
  return unit:assert($meta/tag)
};
  
