"""
	SeisToSegy(filename_in,filename_out;<keyword arguments>)

Convert seis data to SU or SEGY format. The function needs input and output filenames.

# Arguments
- `su=true` : If the flag equals true, converts tu SU format, otherwise to SEGY format

*Credits: AS, 2015*

"""
function SeisToSegy(in,out;su=true)
    if (su==true)
	file_hsize = 0
    else
	file_hsize = 900
	# add commands here to read text and binary headers out.thead and
        # out.bhead and write them to out
    end

    filename_headers = ParseHeaderName(in)
    extent = ReadTextHeader(in)
    n1 = extent.n1
    nx = extent.n2*extent.n3*extent.n4*extent.n5

    stream = open(out,"w")
    total = 60 + n1
    println("ok")
    h_segy = Array{SeisMain.SegyHeader}(undef,1)
    h_seis = Array{Header}(undef,1)
    h1 = Header[]
    push!(h1,SeisMain.InitSeisHeader())
    h1[1].o1 = extent.o1
    h1[1].d1 = extent.d1
    h1[1].n1 = extent.n1

    for j = 1 : nx
	if filename_headers != "NULL"
	    d,h1,e = SeisRead(in,itrace=j,ntrace=1,group="some")
	else
	    println("j=",j)
	    d,e = SeisRead(in,itrace=j,ntrace=1,group="some")
	    println("size(d)=",size(d))
	    h1[1].tracenum = j
    end
    println("test")
	#h_segy[1] = MapHeaders(h1,j,"SeisToSegy")
    h_segy = MapHeaders(h1,j,"SeisToSegy")

    positn = file_hsize + total*(j-1)*4 + segy_count["trace"]
	seek(stream,positn)
	write(stream,convert(Array{Float32,1},d[:]))
	PutSegyHeader(stream,h_segy,n1,file_hsize,j)
    end
    close(stream)

end
