# expkg-zone58.audio.mp3
An XQuery library to extract mp3 metadata as XML using the 
[mpatric/mp3agic library](https://github.com/mpatric/mp3agic)  
The output xml format matches the o/p of the [Xmlcalabash](http://xmlcalabash.com/) metadata extension. 

Use:
''''
 mp3agic:read($f)
''''
Result
````
<metadata src="C:\Users\andy\git\mp3tag-extract\src\test\v24tagswithalbumimage.mp3">
  <tag dir="file" name="ChannelMode">Joint stereo</tag>
  <tag dir="file" name="SampleRate">44100</tag>
  <tag dir="file" name="Bitrate">125</tag>
  <tag dir="file" name="Layer">III</tag>
  <tag dir="file" name="Version">1.0</tag>
  <tag dir="file" name="isVbr">true</tag>
  <tag dir="Id3" name="Composer">COMPOSER23456789012345678901234</tag>
  <tag dir="Id3" name="Artist">ARTIST123456789012345678901234</tag>
  <tag dir="Id3" name="Copyright">COPYRIGHT2345678901234567890123</tag>
  <tag dir="Id3" name="Track">1</tag>
  <tag dir="Id3" name="Url">URL2345678901234567890123456789</tag>
  <tag dir="Id3" name="Album">ALBUM1234567890123456789012345</tag>
  <tag dir="Id3" name="OriginalArtist">ORIGARTIST234567890123456789012</tag>
  <tag dir="Id3" name="Title">TITLE1234567890123456789012345</tag>
  <tag dir="Id3" name="GenreDescription">Pop</tag>
  <tag dir="Id3" name="AlbumImageMimeType">image/png</tag>
  <tag dir="Id3" name="Encoder">ENCODER234567890123456789012345</tag>
  <tag dir="Id3" name="Year">2014</tag>
  <tag dir="Id3" name="Comment">COMMENT123456789012345678901</tag>
</metadata>
````
BaseX 8.2 or greater is required.

# Usage
````
import module namespace mp3 = 'expkg-zone58.audio.mp3';
mp3:tags("C:\Users\andy\Desktop\v24tagswithalbumimage.mp3")
````


# Installation
The library is packaged in the [EXpath](http://expath.org/spec/pkg) xar format with the mp3agic jar included. 
It is targeted at BaseX. It requires at least BaseX 8.2 (because the expkg2012 format is used). 
It can be installed into the BaseX repository by executing:
````
"https://github.com/expkg-zone58/mp3tag-extract/releases/download/v0.1.4/mp3tag-extractor-0.1.4.xar"
=>repo:install()
````
# Tests
The `test.xq` script uses the BaseX [Unit module](http://docs.basex.org/wiki/Unit_Module)

# License

Copyright (c) 2015, Andy Bunce. (Apache 2 License). 
mp3agic Michael Patricios (MIT License). 

# Existdb

Experimental support for [ExistDB](http://exist-db.org/exist/apps/homepage/index.html) is included in the xar (repo.xml,exist.xml)
Requires java binding for XQuery to be enabled in [config.xml]
(http://exist-db.org/exist/apps/doc/configuration.xml?q=conf.xml&field=all&id=D2.2.4#D2.2.4).
Not tested.