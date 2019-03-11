"""
	SeisHeaderInfo(filename;<keyword arguments>)

Print Seis header information to screen. The input is the name of the data file

# Arguments

- `ntrace=100000` : Number of traces to analyze

*Credits: AS, 2015*

"""

function SeisHeaderInfo(filename;ntrace=100000)

	key = fieldnames(Header)
	nhead = length(key)
	filename_headers = ParseHeaderName(filename)
	stream = open(filename_headers)
	NX = GetNumTraces(filename)
	h = GrabHeader(stream,1)
	println("Displaying information for ", filename," (",NX," traces):")
	min_h = zeros(Float32,length(key))
	max_h = zeros(Float32,length(key))
	mean_h = zeros(Float32,length(key))

	for ikey=1:length(key)
		min_h[ikey] = convert(Float32,getfield(h,key[ikey]))
		max_h[ikey] = convert(Float32,getfield(h,key[ikey]))
		mean_h[ikey] += convert(Float32,getfield(h,key[ikey]))
	end

	itrace = 2
	while itrace <= NX
		nx = NX - itrace + 1
		ntrace = nx > ntrace ? ntrace : nx
		position = 4*nhead*(itrace-1)
		seek(stream,position)
		h1 = read!(stream,Array{Header32Bits}(undef,nhead*ntrace))
		h1 = reshape(h1,nhead,convert(Int,ntrace))
		for ikey = 1 : length(key)
			keytype = eval(Meta.parse("typeof(SeisMain.InitSeisHeader().$(string(key[ikey])))"))
			h2 = reinterpret(keytype,vec(h1[ikey,:]))
			a = minimum(h2)
			b = maximum(h2)
			c = mean(h2)
			if (a < min_h[ikey])
				min_h[ikey] = a
			end
			if (b > max_h[ikey])
				max_h[ikey] = b
			end
			mean_h[ikey] += c*ntrace
		end
		itrace += ntrace
	end

	for ikey=1:length(key)
		mean_h[ikey] /= NX
	end
	close(stream)
	println("       Key          Minimum          Maximum             Mean");
	println("=============================================================")
	for ikey=1:length(key)
		@printf("%10s      %11.3f      %11.3f      %11.3f\n",string(key[ikey]),min_h[ikey],max_h[ikey],mean_h[ikey])
	end

end
