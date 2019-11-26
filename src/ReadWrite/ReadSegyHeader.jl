"""
    ReadSegyHeader(filename;<keyword arguments>)

Read the headers of a input file in segy format

# Arguments
- `group="all"` : Options are all, some or gather
- `swap_bytes=true` : If the flag equals true, the function swaps bytes
- `key=[]`
- `minval=0`  
- `maxval=0` 
"""
function ReadSegyHeader(filename_in;swap_bytes="true",group="all",key=" ",minval=0,maxval=0)


#1) Stats on segy header

stream = open(filename_in)

position = 3200

seek(stream, position)

fh = SeisMain.GrabFileHeader(stream)

ntfh = swap_bytes == true ? bswap(fh.netfh) : fh.netfh
fh = 0

if ntfh == -1
	error("add instructions to deal with variable extended text header")
end
if ntfh == 0
	file_hsize = 3600
elseif ntfh > 0
	# file_hsize = 3200 * (ntfh+1) + 400
	file_hsize = 3200 * 1 + 400
else
	error("unknown data format")
end


stream = open(filename_in)

seek(stream, SeisMain.segy_count["ns"] + file_hsize)

if (swap_bytes=="true")
	nt = bswap(read(stream,Int16))
else
	nt = read(stream,Int16)
end
total = 60 + nt

nx = round(Int,(filesize(stream)-file_hsize)/4/total)

println("total number of traces: ",nx)
println("number of samples per trace: ",nt)


itrace = 1
ntrace = nx
tt = nx

if group == "gather"
# Using this option means that the traces are organized as the gather. If traces are not organized, this option won't work

       itrace = nx
       ntrace = 1
       for j=1:nx
       	   h1 = SeisMain.GrabSegyHeader(stream,swap_bytes,nt,file_hsize,j)
	   aux = getfield(h1,Symbol(key))
	   if aux >=minval && aux<=maxval
	      if itrace>j
	      	 itrace = j
	      elseif j > ntrace
	      	 ntrace = j
	      end
	   end
	end
	tt = ntrace - itrace +1
	println(" number of traces in gather: ",tt)
end

h_segy = Array{SeisMain.SegyHeader}(undef,tt)

for i=1:tt
# este position me parece que esta mal + no lo necesito
  j = i + itrace -1
  position = file_hsize + total*(j-1)*4 + SeisMain.segy_count["trace"]
    seek(stream,position)

#este solo ya sabe donde ir

    h_segy[i] = SeisMain.GrabSegyHeader(stream,swap_bytes,nt,file_hsize,j)

end

#podria haber hecho h_segy = push!(h_segy, SeisMain.GrabSegyHeader(stream,swap_bytes,nt,file_hsize,j)
# me parece que no por el tema de definir h_segy pero no estoy segura



close(stream)
println("The output array has the segy data header.")
return h_segy
end
