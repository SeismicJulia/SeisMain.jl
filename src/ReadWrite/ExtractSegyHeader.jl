"""
    ExtractSegyHeader(h,key)

Extract a specific key value from the header array
"""
function ExtractSegyHeader(h::Array{SeisMain.SegyHeader,1},key::AbstractString)

    keytype = eval(Meta.parse("typeof(SeisMain.InitSegyHeader().$(key))"))
    out = keytype[]
    for ix = 1 : length(h)
	push!(out,getfield(h[ix],Symbol(key)))
    end
    return out

end
