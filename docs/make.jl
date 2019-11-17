using Pkg; Pkg.add("Documenter")
using Documenter, SeisMain

makedocs(
	modules = [SeisMain],
	sitename = "SeisMain.jl",
	format = Documenter.HTML(),
	pages = [
	       "Home" => "index.md",
	       "Manual" => Any[
	       		"Guide" => "man/guide.md"],
		"Library" => Any[
			  "Public" => "lib/public.md",
				],
		], 
)

deploydocs(
    repo = "github.com/fercarozzi/SeisMain.jl.git",
    julia = "1.1",
    osname = "linux",
    target = "build"
)
