import module namespace tags = 'expkg-zone58:audio.metadata' at "../main/content/audiotagger.xqm";
declare variable $base:=file:resolve-path("resources/",static-base-uri());
(: declare variable $f:=file:resolve-path("Neil Young - Wolf Moon_(song365.cc).mp3",$base); :)
declare variable $f:=file:resolve-path("23 Hedonism (Just Because You Feel Good).mp3",$base);
tags:read($f)
