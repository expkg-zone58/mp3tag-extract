# expkg-zone58:audio.metadata

An XQuery library to extract metadata from audio files using the 
[jaudiotagger](http://www.jthink.net/jaudiotagger/)  
The output format is XML and follows the style of the o/p of the [Xmlcalabash](http://xmlcalabash.com/) metadata extension. 

##Usage
* audiometa:read($filepath) as element(metadata)
* audiometa:tags($filepath) as element(tag)*

```
import module namespace audiometa = 'expkg-zone58:audio.metadata';

audiometa:read($filepath)
```

Result:

```
<metadata src="23 Hedonism (Just Because You Feel Good).mp3">
   <tag dir="ID3" name="ALBUM">Stoosh</tag>
  <tag dir="ID3" name="ALBUM_ARTIST">Skunk Anansie</tag>
  <tag dir="ID3" name="ALBUM_ARTIST_SORT">Skunk Anansie</tag>
  <tag dir="ID3" name="AMAZON_ID">B000024SOM</tag>
  <tag dir="ID3" name="ARTIST">Skunk Anansie</tag>
  <tag dir="ID3" name="ARTIST_SORT">Skunk Anansie</tag>
  <tag dir="ID3" name="BARCODE">724384225827</tag>
  <tag dir="ID3" name="CATALOG_NO">724384225827/842258 2</tag>
  <tag dir="ID3" name="COMPOSER">Len Arran/Skin</tag>
  <tag dir="ID3" name="COVER_ART">image/jpeg::63772</tag>
  <tag dir="ID3" name="DISC_NO">1</tag>
  <tag dir="ID3" name="DISC_TOTAL">1</tag>
  <tag dir="ID3" name="GENRE">Rock/Pop</tag>
  <tag dir="ID3" name="ISRC">DEG129600971/GBBTF9600005</tag>
  <tag dir="ID3" name="LYRICS">I hope you're feeling happy now
I/tag>
  <tag dir="ID3" name="MEDIA">CD</tag>
  <tag dir="ID3" name="MIXER">mixAdi WinmanbassCass LewisdrumsMark RichardsonpercussionMark RichardsonthereminSkinbackground vocalsMark Richardsonbackground vocalsCass Lewisbackground vocalsSkinguitarsAcelead vocalsSkin</tag>
  <tag dir="ID3" name="MUSICBRAINZ_ARTISTID">e212efdf-98b2-4dce-92ed-62cfc1e29854</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASEARTISTID">e212efdf-98b2-4dce-92ed-62cfc1e29854</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASEID">9618e7b9-3137-46ef-bf5a-764dd1844218</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASE_COUNTRY">XE</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASE_GROUP_ID">cfd79ed2-d63b-3564-b3b4-75cfc2afd0cc</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASE_STATUS">official</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASE_TRACK_ID">375ee31c-a8e5-3230-9c0c-51a23e44185e</tag>
  <tag dir="ID3" name="MUSICBRAINZ_RELEASE_TYPE">album</tag>
  <tag dir="ID3" name="MUSICBRAINZ_TRACK_ID">Owner="http://musicbrainz.org"; Data="36 bytes"; </tag>
  <tag dir="ID3" name="ORIGINAL_YEAR">1996</tag>
  <tag dir="ID3" name="RECORD_LABEL">One Little Indian Records</tag>
  <tag dir="ID3" name="TITLE">Hedonism (Just Because You Feel Good)</tag>
  <tag dir="ID3" name="TRACK">5</tag>
  <tag dir="ID3" name="TRACK_TOTAL">5</tag>
  <tag dir="ID3" name="YEAR">1996</tag>
</metadata>
```
Artwork
`COVER_ART` tags indicate the presence of art work. 
``` 
   audiometa:tags($f)[@name="COVER_ART"]
<tag dir="ID3" name="COVER_ART">image/jpeg::63772</tag>

 let $artmap:=audiometa:artwork($f)
 return file:write-binary("c:\tmp\art.jpg",$artmap?binaryData)
```

# Installation
The library is packaged in the [EXpath](http://expath.org/spec/pkg) xar format with the jaudiotagger jar
(jaudiotagger-2.2.6-SNAPSHOT.jar 2016-06-07)  included. It is targeted at BaseX and tested against BaseX version 8.6.2. 
It can be installed into the BaseX repository by executing:
````
"https://github.com/expkg-zone58/mp3tag-extract/releases/download/v0.8.0/mp3tag-extractor-0.8.0.xar"
=>repo:install()
````
# Tests
The `test.xqm` script uses the BaseX [Unit module](http://docs.basex.org/wiki/Unit_Module)

# License

Copyright (c) 2017, Andy Bunce. (Apache 2 License). 
jaudiotagger ijabz  (LGPL License). 

# History
* Namespace changed for v0.8.
* Versions before 0.5 used the https://github.com/mpatric/mp3agic library. 