push!(LOAD_PATH, "../src/")

using Pkg; Pkg.add("Documenter")
using Documenter, SeisMain

makedocs(
	modules = [SeisMain],
	doctest = false,
 	clean = true,
	checkdocs = :all,
<<<<<<< HEAD
=======
	assets = ["assets/logo.png"]
>>>>>>> parent of d04e9e3... update logo
	sitename = "SeisMain.jl",
	format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing)== "true",
		assets = ["assets/logo.png"],
		),
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
    target = "build",
    deps = nothing,
    make = nothing
)
