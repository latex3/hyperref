-- Build script for test-hyperref

-- Build script for hyperref  (check only)
module = "hyperref"
--sourcefiles = {'*.dtx'}
installfiles = {'*.def','*.sty'}

checkconfigs = {"build","config-3"}
checkengines = {"pdftex","luatex"}
checkruns = 2


kpse.set_program_name ("kpsewhich")
if not release_date then
 dofile ( kpse.lookup ("l3build.lua"))
end
