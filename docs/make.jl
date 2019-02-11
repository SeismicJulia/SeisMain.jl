using Pkg; Pkg.add("Documenter")
using Documenter, SeisMain

makedocs(
	modules = [SeisMain],
	doctest = false,
	sitename="SeisMain Documentation",
	

