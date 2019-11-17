using Pkg; Pkg.add("Documenter")
using Documenter, SeisMain

makedocs(
	modules = [SeisMain],
	doctest = false,
 	clean = true,
	checkdocs = :all,
	sitename = "SeisMain.jl",
	format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing)== "true"),
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
    target = "build"
)
