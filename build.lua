-- Build script for hyperref

module = "hyperref"

docfiledir   = "doc"
docfiles     = {"paper.pdf", "slides.pdf", "*.html", "*.css","doc/*.tex"}
textfiles    = {"*.md", "*.txt"}
installfiles = {"*.def", "*.sty", "*.cfg"}
tdslocations = {
  "doc/latex/hyperref/ChangeLog.txt",
  "doc/latex/hyperref/README.md",
  "doc/latex/hyperref/backref.pdf",
  "doc/latex/hyperref/hyperref.pdf",
  "doc/latex/hyperref/manifest.txt",
  "doc/latex/hyperref/hyperref-doc.css",
  "doc/latex/hyperref/hyperref-doc.html",
  "doc/latex/hyperref/hyperref-doc.pdf",
  "doc/latex/hyperref/hyperref-linktarget.pdf",
  "doc/latex/hyperref/hyperref-doc2.html",
  "doc/latex/hyperref/hyperref-doc3.html",
  "doc/latex/hyperref/hyperref-doc4.html",
  "doc/latex/hyperref/hyperref-doc5.html",
  "doc/latex/hyperref/hyperref-doc6.html",
  "doc/latex/hyperref/nameref.pdf",
  "doc/latex/hyperref/xr-hyper.pdf",
  "doc/latex/hyperref/paper.pdf",
  "doc/latex/hyperref/slides.pdf",
  "doc/latex/hyperref/hyperref-doc.tex",
  "source/latex/hyperref/backref.dtx",
  "source/latex/hyperref/bmhydoc.sty",
  "source/latex/hyperref/hluatex.dtx",
  "source/latex/hyperref/hyperref.dtx",
  "source/latex/hyperref/hyperref.ins",
  "source/latex/hyperref/nameref.dtx",
  "source/latex/hyperref/xr-hyper.dtx",  
  "source/latex/hyperref/doc/paperslides99.zip",  
  "tex/latex/hyperref/backref.sty",
  "tex/latex/hyperref/hdvipdfm.def",
  "tex/latex/hyperref/hdvips.def",
  "tex/latex/hyperref/hdvipson.def",
  "tex/latex/hyperref/hdviwind.def",
  "tex/latex/hyperref/hluatex.def",
  "tex/latex/hyperref/hpdftex.def",
  "tex/latex/hyperref/htex4ht.cfg",
  "tex/latex/hyperref/htex4ht.def",
  "tex/latex/hyperref/htexture.def",
  "tex/latex/hyperref/hvtex.def",
  "tex/latex/hyperref/hvtexhtm.def",
  "tex/latex/hyperref/hvtexmrk.def",
  "tex/latex/hyperref/hxetex.def",
  "tex/latex/hyperref/hyperref.sty",
  "tex/latex/hyperref/hypertex.def",
  "tex/latex/hyperref/minitoc-hyper.sty",
  "tex/latex/hyperref/nameref.sty",
  "tex/latex/hyperref/nohyperref.sty",
  "tex/latex/hyperref/ntheorem-hyper.sty",
  "tex/latex/hyperref/pd1enc.def",
  "tex/latex/hyperref/pdfmark.def",
  "tex/latex/hyperref/psdextra.def",
  "tex/latex/hyperref/puarenc.def",
  "tex/latex/hyperref/puenc.def",
  "tex/latex/hyperref/puenc-extra.def",
  "tex/latex/hyperref/puenc-greekbasic.def",
  "tex/latex/hyperref/puvnenc.def",
  "tex/latex/hyperref/xr-hyper.sty"
}

specialformats = specialformats or {}
specialformats["latex"] = specialformats["latex"] or
  {
    pdftexdev     = {binary="pdftex",format = "pdflatex-dev"},
  }


checkconfigs = {"build","config-pvt","config-3","config-xetex","config-pdftex"}
checkengines = {"pdftex","etex","luatex"}

-- for dev testing
-- checkengines = {"pdftex","pdftexdev","etex","luatex"}
-- checkengines = {"pdftex","pdftexdev"}
-- checkconfigs = {"config-dev"}
-- temp settings disable checks while testing ctan build
-- testfiledir= "disabled"
-- checkconfigs={}
-- checkengines = {"pdftex"}

checkruns = 2

typesetexe  = "lualatex"

sourcefiles = {
  "*.dtx",
  "*.ins",
  "*-hyper.sty",
  "bmhydoc.sty",
  "paperslides99.zip"
}





function checkinit_hook ()
local dvipdfmxversion=0
local pipe = io.popen'xdvipdfmx --version'
for line in pipe:lines() do
    if string.match(line,"xdvipdfmx Version") then
      dvipdfmxversion=tonumber(string.match(line,"%d+"))
     end
end
pipe:close()
if (dvipdfmxversion <= 20200315) then
excludetests={"unicode-test","87-pdfversion"}
end
return 0
end



--excludefiles={"hyperref/hyperref-doc.tex"}

typesetfiles = {"hyperref-doc.tex", 
                "backref.dtx", 
                "hyperref.dtx", 
                "nameref.dtx",
                "xr-hyper.dtx",
                "hyperref-linktarget.dtx"}

local function type_manual()
  print("Special Typesetting hyperref-doc")
  local file = jobname("doc/hyperref-doc.tex")
  errorlevel = (runcmd("lualatex "..file, typesetdir, {"TEXINPUTS","LUAINPUTS"})
  + runcmd("lualatex "..file, typesetdir, {"TEXINPUTS","LUAINPUTS"})
  + runcmd("htlatex "..file, typesetdir, {"TEXINPUTS","LUAINPUTS"})
  + cp("*.html", typesetdir, docfiledir) + cp("*.css", typesetdir, docfiledir))
  + cp("*.pdf", typesetdir, docfiledir)
  if errorlevel ~= 0 then
    error("Error!!: Typesetting "..file..".tex")
    return errorlevel
  end
  return 0
end

specialtypesetting = { }
specialtypesetting["hyperref-doc.tex"] = {func = type_manual}

cleanfiles = { "doc/*.html", "doc/*.css"}

flatten = false
packtdszip = true


-- l3build tag auto increases final letter
-- l3build tag AUTO increases .two-digit number and sets final letter to 'a'

tagfiles={"README.md","xr-hyper.sty","*.dtx","doc/*.tex"}
function update_tag(file,content,tagname,tagdate)

local tagpattern="(%d%d%d%d[-/]%d%d[-/]%d%d) v(%d+[.])(%d+)(%l)"
local oldv,newv
if tagname == 'auto' or tagname == 'AUTO' then
  local i,j,olddate,a,b,c
  i,j,olddate,a,b,c= string.find(content, tagpattern)
  if i == nil then
    print('OLD TAG NOT FOUND')
    return content
  else
    print ('FOUND: ' .. olddate .. ' v' .. a .. b .. c)
    oldv = olddate .. ' v' .. a .. b .. c
    if tagname == 'AUTO' then
      newv = tagdate .. ' v'  .. a .. string.format("%02d",math.floor(b + 1)) .. 'a'
    else
      newv = tagdate .. ' v'  .. a .. b .. string.char(string.byte(c)+1)
    end
    print('USING OLD TAG: ' .. oldv)
    print('USING NEW TAG: ' .. newv)
    local oldpattern = string.gsub(oldv,"[-/]", "[-/]")
    content=string.gsub(content,oldpattern,newv)
    return content
  end
else
  error("only automatic tagging supported")
end
end
