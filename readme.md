# expkg-zone58.audio.mp3
An XQuery library to extract mp3 metadata as XML using the 
[jaudiotagger](http://www.jthink.net/jaudiotagger/)  
The output xml format follows the style of the o/p of the [Xmlcalabash](http://xmlcalabash.com/) metadata extension. 

Use:
''''
 tags:read($f)
''''
Result
````
<metadata src="23 Hedonism (Just Because You Feel Good).mp3">
  <tag dir="ID3" name="ALBUM">[1996] Stoosh</tag>
  <tag dir="ID3" name="ALBUM_ARTIST">Skunk Anansie</tag>
  <tag dir="ID3" name="ARTIST">Skunk Anansie</tag>
  <tag dir="ID3" name="COMPOSER">Len Arran/Skin</tag>
  <tag dir="ID3" name="COVER_ART">image/jpg::9583</tag>
  <tag dir="ID3" name="GENRE">Rock/Pop</tag>
  <tag dir="ID3" name="LYRICS">I hope you're feeling happy now..
</tag>
  <tag dir="ID3" name="RECORD_LABEL">Sony</tag>
  <tag dir="ID3" name="TITLE">Hedonism (Just Because You Feel Good)</tag>
  <tag dir="ID3" name="TRACK">23</tag>
  <tag dir="ID3" name="TRACK_TOTAL">23</tag>
  <tag dir="ID3" name="YEAR">1996</tag>
</metadata>
````
BaseX 8.2 or greater is required.

# Usage
````
import module namespace mp3 = 'expkg-zone58.metadata.audio';
mp3:tags("C:\Users\andy\Desktop\v24tagswithalbumimage.mp3")
````


# Installation
The library is packaged in the [EXpath](http://expath.org/spec/pkg) xar format with the jaudiotagger jar included. 
It is targeted at BaseX. It requires at least BaseX 8.2 (because the expkg2012 format is used). 
It can be installed into the BaseX repository by executing:
````
"https://github.com/expkg-zone58/mp3tag-extract/releases/download/v0.1.4/mp3tag-extractor-0.5.1.xar"
=>repo:install()
````
# Tests
The `test.xq` script uses the BaseX [Unit module](http://docs.basex.org/wiki/Unit_Module)

# License

Copyright (c) 2016, Andy Bunce. (Apache 2 License). 
jaudiotagger ijabz  (LGPL License). 

# History
Versions before 0.5 used the https://github.com/mpatric/mp3agic library.