
rem */\(1+[a-z0-9\-]\)\.\(2+[a-z]\)\.*
rem l3build save -e\2 \1


l3build save  -eetex test1
l3build save  -eluatex test1
l3build save  -epdftex test1


l3build save -cconfig-pvt -eluatex 25-sec-non-ascii
l3build save -cconfig-pvt -epdftex 25-sec-non-ascii
l3build save -cconfig-pvt -eluatex 40-test-pdfhighlight
l3build save -cconfig-pvt -epdftex 40-test-pdfhighlight
l3build save -cconfig-pvt -eluatex issue49-textfields-utf8
l3build save -cconfig-pvt -epdftex issue49-textfields-utf8
l3build save -cconfig-pvt -eluatex issue93-formfieldspace
l3build save -cconfig-pvt -epdftex issue93-formfieldspace
l3build save -cconfig-pvt -eluatex test-bm-pu-licr
l3build save -cconfig-pvt -epdftex test-bm-pu-licr
l3build save -cconfig-pvt -eluatex test0-pdf
l3build save -cconfig-pvt -epdftex test0-pdf
l3build save -cconfig-pvt -eluatex test4-pdf
l3build save -cconfig-pvt -epdftex test4-pdf
l3build save -cconfig-pvt -eluatex test6-pdf
l3build save -cconfig-pvt -epdftex test6-pdf
l3build save -cconfig-pvt -eluatex test8
l3build save -cconfig-pvt -epdftex test8
l3build save -cconfig-pvt -eluatex testams
l3build save -cconfig-pvt -epdftex testams
l3build save -cconfig-pvt -eluatex testbmgl
l3build save -cconfig-pvt -epdftex testbmgl
l3build save -cconfig-pvt -eluatex testbmu
l3build save -cconfig-pvt -epdftex testbmu
l3build save -cconfig-pvt -eluatex testbookmark
l3build save -cconfig-pvt -epdftex testbookmark
l3build save -cconfig-pvt -eluatex testform
l3build save -cconfig-pvt -epdftex testform
l3build save -cconfig-pvt -eluatex testnb-pdf
l3build save -cconfig-pvt -epdftex testnb-pdf
l3build save -cconfig-pvt -eluatex unicode-test
l3build save -cconfig-pvt -epdftex unicode-test
REM
REM Failed tests for configuration config-3:
REM
REM   Check failed with difference files
REM   - ./build/test-config-3/test1-pdf.luatex.pdf.fc
REM   - ./build/test-config-3/test1-pdf.pdftex.pdf.fc
REM
REM Failed tests for configuration config-xetex:
REM
REM   Check failed with difference files
REM   - ./build/test-config-xetex/unicode-test.xetex.pdf.fc
