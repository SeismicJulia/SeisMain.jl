"""
        SegyHeaderInfo(filename_in)

Print segy header information to screen. The input is the name of the headers file

"""
function SegyHeaderInfo(h_segy)

#requires using Printf, Statistics

println("Calculating statistics.")

#key gets all the types of the composite type SegyHeader).
key = fieldnames(SeisMain.SegyHeader)

min_h = zeros(Float64,length(key))
max_h = zeros(Float64,length(key))
mean_h = zeros(Float64,length(key))


for ikey=1:length(key)
		min_h[ikey] = convert(Float64,getfield(h_segy[1],key[ikey]))
		max_h[ikey] = convert(Float64,getfield(h_segy[1],key[ikey]))
		mean_h[ikey] += convert(Float64,getfield(h_segy[1],key[ikey]))
end

nx = size(h_segy,1)

for itrace = 2:nx
	for ikey = 1 : length(key)
		aux = convert(Float64,getfield(h_segy[itrace],ikey))
		if (aux < min_h[ikey])
			min_h[ikey] = aux
		end
		if ( aux > max_h[ikey])
			max_h[ikey] = aux
		end
		mean_h[ikey] += aux
	end
end

for ikey=1:length(key)
	mean_h[ikey] /= nx
end


	println("       Key          Minimum          Maximum             Mean");
	println("=============================================================")
	for ikey=1:length(key)
		@printf("%10s      %11.3f      %11.3f      %11.3f\n",string(key[ikey]),min_h[ikey],max_h[ikey],mean_h[ikey])
	end

end
