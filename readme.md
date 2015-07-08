# expkg-zone58.audio.mp3
An XQuery library to extract mp3 metadata as XML using the 
[mpatric/mp3agic library](https://github.com/mpatric/mp3agic)  
The output xml format matches the o/p of the [Xmlcalabash](http://xmlcalabash.com/) metadata extension. 
````
<metadata>
 <tag name=".." dir=".." type="..">value</tag>
 <tag ..
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
let $zar:='https://github.com/expkg-zone58/metadata-extract/releases/download/v1.0.6/metadata-extractor-1.0.6.xar'
return repo:install($zar)
````
# Tests
The `test.xq` script uses the BaseX [Unit module](http://docs.basex.org/wiki/Unit_Module)

# License
Copyright (c) 2015, Andy Bunce. (Apache 2 License). 
mp3agic Michael Patricios (MIT License). 

# Existdb
Experimental support for ExistDB is included in the xar (repo.xml,exist.xml)
Requires java binding for XQuery to be enabled in config.xml.
http://exist-db.org/exist/apps/doc/configuration.xml?q=conf.xml&field=all&id=D2.2.4#D2.2.4