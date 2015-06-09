# EPUB KB policy testing

## Contents of this repository

A set of *EPUB* test files, specifically created for the purpose of testing an automated procedure to validate *EPUB*s  against KB institutional policies. These policies require the following:

* Files must be valid *EPUB* (version 2 or 3)
* File may not contain DRM or encryption (edge case: font mangling, should be permitted)
* All resources in the container fall within the Core Media Types 
* No Digital Talking Book (DTB) content documents

As a result, most of the files in this repo deliberately violate one or more of the above requirements. 

Some of the files were newly created (with a little help from [Sigil](http://sigil-ebook.com/)), whereas others were taken or adapted from other openly-licensed data sets. 

## Directories

* **content** - uncompressed contents of each test file (each subdirectory represents one epub)
* **build** - actual epub builds
* **epubcheckout** - epubcheck output
* **pubresources** - various resources (files) that were used for creating the epubs.

## Build script

The script *build.sh* iterates over all subdirectories in the *content* folder and compresses the contents of each to a functional *epub* file in the *build* directory.

For an explanation of how the build process works, see [here](https://gist.github.com/bitsgalore/da04413787931d20a8bf).

## Analyse script

The script *analyse.sh* validates all epubs in the *build* directory with [Epubcheck](https://github.com/idpf/epubcheck) (it uses both the stable 3.0 version and the alpha 4.0.0 one). You have to install these yourself on your system. Then update the file paths to *epubcheck3Jar* and *epubcheck4Jar* at the top of the script.

## Description of test files

|File name|Epub version|Description|Epubcheck (3,4) output|
|:--|:--|:--|:--|
|[epub20_minimal.epub](build/epub20_minimal.epub?raw=true)|2|Basic file with one text resource and one image|[3](epubcheckout/3.0.1/epub20_minimal.xml),[4](epubcheckout/4.0.0-alpha11/epub20_minimal.xml)|
|[epub20_minimal_encryption.epub](build/epub20_minimal_encryption.epub?raw=true)|2|Includes encryption.xml resource in `META-INF`, indicating that main text resource is encrypted (text resource is not *actually* encrypted, BTW)|[3](epubcheckout/3.0.1/epub20_minimal_encryption.xml),[4](epubcheckout/4.0.0-alpha11/epub20_minimal_encryption.xml)|
|[epub30_font_obfuscation.epub](build/epub30_font_obfuscation.epub?raw=true)|3|Includes fonts that are obfuscated (which results in *hasEncryption* in epubcheck). Taken from [EPUB 3 Sample Documents](https://code.google.com/p/epub-samples/) ([*wasteland with OTF fonts, obfuscated*](https://code.google.com/p/epub-samples/downloads/detail?name=wasteland-otf-obf-20120118.epub&can=2&q=)).|[3](epubcheckout/3.0.1/epub30_font_obfuscation.xml),[4](epubcheckout/4.0.0-alpha11/epub30_font_obfuscation.xml)|
|[epub20_foreign_resource_no_fallback.epub](build/epub20_foreign_resource_no_fallback.epub?raw=true)|2|Includes JP2 image, which is a format that is not on the list of Core Media Types; no fallback defined|[3](epubcheckout/3.0.1/epub20_foreign_resource_no_fallback.xml),[4](epubcheckout/4.0.0-alpha11/epub20_foreign_resource_no_fallback.xml)|
|[epub20_foreign_resource_with_fallback.epub](build/epub20_foreign_resource_with_fallback.epub?raw=true)|2|Includes JP2 image, which is a format that is not on the list of Core Media Types; fallback defined in manifest, identifier in content document|[3](epubcheckout/3.0.1/epub20_foreign_resource_with_fallback.xml),[4](epubcheckout/4.0.0-alpha11/epub20_foreign_resource_with_fallback.xml)|
|[epub20_foreign_resource_with_fallback_noID.epub](build/epub20_foreign_resource_with_fallback_noID.epub?raw=true)|2|Includes JP2 image, which is a format that is not on the list of Core Media Types; fallback defined in manifest, no identifier in content document|[3](epubcheckout/3.0.1/epub20_foreign_resource_with_fallback_noID.xml),[4](epubcheckout/4.0.0-alpha11/epub20_foreign_resource_with_fallback_noID.xml)|
|[epub20_dtbook.epub](build/epub20_dtbook.epub?raw=true)|2|Includes Digital Talking Book content. Adapted from [threepress](https://code.google.com/p/threepress/source/browse/branches/bookworm-caching/library/test-data/data/hauy.epub?r=583), published under [BSD 3](http://opensource.org/licenses/BSD-3-Clause) license.|[3](epubcheckout/3.0.1/epub20_dtbook.xml),[4](epubcheckout/4.0.0-alpha11/epub20_dtbook.xml)|
|[epub20_xpgt.epub](build/epub20_xpgt.epub?raw=true)|2|Includes style definitions as [Adobe Page Template](http://wiki.mobileread.com/wiki/XPGT).|[3](epubcheckout/3.0.1/epub20_xpgt.xml),[4](epubcheckout/4.0.0-alpha11/epub20_xpgt.xml)|
|[epub20_missingfontresource.epub](build/epub20_missingfontresource.epub?raw=true)|2|CSS stylesheet contains reference to font resource that is not part of the package.|[3](epubcheckout/3.0.1/epub20_missingfontresource.xml),[4](epubcheckout/4.0.0-alpha11/epub20_missingfontresource.xml)|


## How to add a new test file

1. Add uncompressed directory structure to *content* folder
2. Run script to update the builds
3. Add descriptive entry to table above

<!--

## Core Media Types in *EPUB* 2 and *3*

The following table lists all permitted Core Media Types of *EPUB* 3 (which is a superset of those in *EPUB* 2, but see below):

| Media Type                  | Description                                        |
|-----------------------------|----------------------------------------------------|
| image/gif                   | GIF Images                                         |
| image/jpeg                  | JPEG Images                                        |
| image/png                   | PNG Images                                         |
| image/svg+xml               | SVG documents                                      |
| application/xhtml+xml       | XHTML5 Content Documents, EPUB Navigation Document |
| application/x-dtbncx+xml    | NCX (superseded)                                   |
| application/vnd.ms-opentype | OpenType fonts                                     |
| application/font-woff       | WOFF fonts                                         |
| application/smil+xml        | EPUB Media Overlay documents                       |
| application/pls+xml         | Text-to-Speech Pronunciation lexicons              |
| audio/mpeg                  | MP3 audio                                          |
| audio/mp4                   | AAC LC audio using MP4 container                   |
| text/css                    | EPUB Style Sheets                                  |
| text/javascript             | Scripts                                            |


The table below indicates the support of these Core Media Types in *EPUB* 2 and 3:

| Media Type                  | EPUB 2 | EPUB 3 |
|-----------------------------|--------|--------|
| image/gif                   | ✓      | ✓      |
| image/jpeg                  | ✓      | ✓      |
| image/png                   | ✓      | ✓      |
| image/svg+xml               | ✓      | ✓      |
| application/xhtml+xml       | ✓      | ✓      |
| application/x-dtbncx+xml    | ✓      | ✓      |
| application/vnd.ms-opentype | -      | ✓      |
| application/font-woff       | -      | ✓      |
| application/smil+xml        | -      | ✓      |
| application/pls+xml         | -      | ✓      |
| audio/mpeg                  | -      | ✓      |
| audio/mp4                   | -      | ✓      |
| text/css                    | ✓      | ✓      |
| text/javascript             | -      | ✓      |


Most of the *EPUB* 3 Core Media Types are also supported by *EPUB* 2, with the exception of fonts (*OpenType* and *WOFF*), Media Overlay Documents, Text-to-Speech Overlay documents, *MP3* and *AAC LC* Audio and scripts. In addition, for Content Documents *EPUB* 2 allows the use of the *Digital Talking Book* format (DTBook) as an alternative to *XHTML1.1*. This is no longer the case in *EPUB* 3. However, Section 2.2 (Reading System Conformance) of *EPUB Publications* states that 

> [a]n EPUB Reading System (...) *should* process EPUB version 2 Publications (...)
> 

## Detection of Digital Talking Book content documents

From <http://www.idpf.org/epub/20/spec/OPS_2.0.1_draft.htm#TOC1.4.1.1>:

> A document is considered an OPS Content Document if and only if:
>
>   i. it uses a combination of the XHTML subset defined in this document and OPS-specific content extensions such as Inline XML Islands and Inline SVG; or
>   ii. it is a document with the MIME media type application/x-dtbook+xml which conforms to the DTB specification (http://www.niso.org/standards/resources/Z39-86-2005.html) and must not use OPS-specific content extensions such as Inline XML Islands or Inline SVG; or
>   iii. it is an XML document of any other MIME media type and is thus an Out-Of-Line XML Island

Samples here:

<http://robertjszmidt.pl/node/284>
<https://code.google.com/p/threepress/source/browse/branches/bookworm-caching/library/test-data/data/hauy.epub?r=583>


-->

## License

All files here are released under the Creative Commons 3.0 BY-SA license, unless stated otherwise.