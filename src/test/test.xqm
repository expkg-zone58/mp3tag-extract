(:~
 : unit tests for metadata module
 :)
module namespace test = 'http://basex.org/modules/xqunit-tests'; 

import module namespace metadata = "expkg-zone58.audio.mp3" at "../main/content/mp3magic.xqm";


declare variable $test:mp3:=file:resolve-path("v24tagswithalbumimage.mp3",file:base-dir() );
 
(:~ we get tags :)
declare
  %unit:test
  function test:success-function() {
  let $meta:=metadata:read($test:mp3)
  return unit:assert($meta/tag)
};
  
