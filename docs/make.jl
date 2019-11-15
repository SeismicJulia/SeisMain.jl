using Pkg; Pkg.add("Documenter")
using Documenter, SeisMain

makedocs(
	modules = [SeisMain],
	doctest = false,
	sitename = "SeisMain.jl",
	pages = [
	       "Home" => "index.md",
	       "Manual" => Any[
	       		"Guide" => "man/guide.md"],
		"Library" => Any[
			  "Public" => "lib/public.md",
			  "Internals" => map(
                	     s -> "lib/internals/$(s)",
                sort(readdir(joinpath(@__DIR__, "src/lib/internals")))
		),
		],
		], 
)

deploydocs(
    repo = "github.com/SeismicJulia/SeisMain.jl.git",
)