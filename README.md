# README for hyperref bundle

Version 2020-05-15 v7.00e

## INTRODUCTION

This package is used to emend cross-referencing commands in LaTeX to
produce some sort of `\special` commands; there are backends for the
`\special` set defined for HyperTeX dvi processors, for embedded pdfmark
commands for processing by Acrobat Distiller (dvips and dvipsone), for
dviwindo, for pdfTeX, for dvipdfm, for TeX4ht, and for VTEX's pdf and HTML
backends.

Included are:

 1. `hyperref` The main hyperlinking functionality.
 2. `backref` a package by David Carlisle to provide links back from
    bibliography to the main text; these are hypertext links after using
    `hyperref`.
 3. `nameref` a package to allow reference to the *names* of sections rather
    than their numbers.

## DOWNLOAD

`hyperref` is available on CTAN:https://ctan.org/pkg/hyperref

Also a ZIP file is provided that contains the files, already sorted
in a TDS tree:
  CTAN:http://mirrors.ctan.org/install/macros/latex/contrib/hyperref.tds.zip

"CTAN:" means one of the 'Comprehensive TeX Archive Network'
nodes or one of its mirrors.  This is explained in
  https://texfaq.org/FAQ-archives

The main repository of hyperref is located at github
  https://github.com/latex3/hyperref

## INSTALLATION

### Installation with ZIP file in TDS format

The ZIP file [hyperref.tds.zip](http://mirrors.ctan.org/install/macros/latex/contrib/hyperref.tds.zip)
contains the files sorted in a TDS tree. Thus you can directly unpack the ZIP file
inside a TDS tree. (See [CTAN:tds.zip](https://ctan.org/pkg/tds) for an explanation of TDS.)
Example:

```
  cd /...somewhere.../texmf
  unzip /...downloadpath.../hyperref.tds.zip
```

Do not forget to refresh the file name database of this TDS tree.
Example for TeXLive:

```
  mktexlsr /...somewhere.../texmf
```

### Manual installation

 1. Download the hyperref files from CTAN or the TUG server.
    If necessary, unpack them.
 2. Generate the package and driver files: `tex hyperref.ins`
 3. Install the files `*.sty`, `*.def`, and `*.cfg` in your TDS tree:
    `cp *.sty *.def *.cfg TDS:tex/latex/hyperref/`.
    Replace `TDS:` by the prefix of your TDS tree (`texmf` directory).
    The exception is `bmhydoc.sty`, it belongs to the source files
    (`TDS:source/latex/hyperref/`).
 4. Copy the documentation files to "`TDS:doc/latex/hyperref/`":
    manual.pdf, README.md, ChangeLog.txt,
    slides.pdf, paper.pdf, hyperref.pdf, backref.pdf,
    nameref.pdf (Also the HTML version of the manual can be put there).
 5. Update the databases if necessary, eg. for TeXLive:
    `mktexlsr .../texmf`

## AUTHORS/MAINTAINERS

 * Sebastian Rahtz (died 2016)
 * Heiko Oberdiek  (inactive)
 * The LaTeX3 Project

## BUG REPORTS

A bug report should contain:

 * Comprehensive problem description. This includes error or
   warning messages.
   * `\errorcontextlines=\maxdimen` can be added in the TeX code
     to get more information in TeX error messages.
 * Minimal test file that shows the problem, but does not
   contain any unnecessary packages and code.
 * Used drivers/programs.
 * Version information about used packages and programs.
   * If you are using LaTeX, then add "`\listfiles`". Then
     a list of version informations is printed at the end
     of the LaTeX run.
 * Please no other files than the minimal test file.
   The other files .log, .dvi, .ps, .pdf are seldom necessary,
   so send them only on request.

## Bug address

A bug tracker is available at github:
    https://github.com/latex3/hyperref/issues

## Vietnamese part

Responsible for the Vietnamese translations of the
\autoref names and puvnenc.def are:

- Han The Thanh `<hanthethanh [at] gmail [dot] com>`
- Reinhard Kotucha `<reinhard [dot] kotucha at web [dot] de>`

## Arabic part

Responsible for the additions to PU encoding for Arabi is
  Youssef Jabri `<yjabri [at] ensa [dot] univ-oujda [dot] ac [dot] ma>`

## KNOWN PROBLEMS

 * (half-done) hyper images (link from thumbnail in text)
 * Relative links are not sorted out or documented well.
   For PDF generation:
   * With baseurl: all links are considered relative to this URL.
   * Without baseurl: a relative link without "file:" can be
     achieved by:
     ```
      \begingroup
        \hypersetup{linkfileprefix={}}%
        \href{../foo/bar.html}{bar.html}
      \endgroup
      ```
 * ...

## TODO

 * modules
 * bookmark organisation
 * documentation
 * PDF threads
 * more for PDF forms
   * per object setting
   * vary gap between text and box
 * PostScript driver: the current implementation doesn't really support
   nested links. The start positions should be remembered in a stack,
   but there are complications with page breaks.
 * ...
