-- Build script for test-hyperref

-- Build script for hyperref  (check only)
module = "hyperref"

installfiles = {'*.def','*.sty'}

checkconfigs = {"build","config-pvt","config-3","config-xetex"}
checkengines = {"pdftex","etex","luatex"}
checkruns = 2

-- start at getting cyan build organised, not complete yet (mkctan script still used)
sourcefiles        = {"*.dtx", "*.ins", "bmhydoc.sty","*-hyper.sty","paperslides99.zip","psdmapshortnames.pl","doc/*.???"}
typesetfiles={"doc/manual.tex","doc/options.tex","backref.dtx","hyperref.dtx","nameref.dtx"}

flatten = false

-- bundlectan= {error('Use ./mkctan for now')}

kpse.set_program_name ("kpsewhich")
if not release_date then
 dofile ( kpse.lookup ("l3build.lua"))
end
