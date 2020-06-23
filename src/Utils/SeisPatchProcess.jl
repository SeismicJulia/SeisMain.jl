"""
      SeisPatchProcess(in,out;<keyword arguments>)
Read data from disk, split into multidimensional overlapping patches,
apply processes, merge patches with tapers, and write to disk.

Processing of patches can be done in parallel by running the code using
(for example): julia -p 2 script_name.jl

Important Notice: You must make declare global variables f and f_param on
every processor. You can do this in your main function by typing (for
example):
@everywhere global f_param = ["style"=>"mxmyhxhy", "Niter"=> 100, "alpha"=>1,"fmax"=>80]
@everywhere global f = [SeisPOCS]

f is an array of functions that have the following syntax:
d2, h2 = f(d1,h1,f_param), where
param is a dictionary (Dict) of parameters for the function.

note that param should contain parameters for the patching and unpatching operations.

to execute the code type:  julia -p 4 my_code.jl where 4 can be replaced
    with the number of processors you wish to use.
*Credits: A. Stanton*
"""
function SeisPatchProcess(in,out,functions,param_patch=Dict(),param_f=Dict();patch_file="patch",patch_out="patch_function",rm=1)

extent = SeisMain.ReadTextHeader(in)
println(extent.n1)

    patches,npatch = SeisPatch(in,patch_file;param_patch...)

	list=patch_list[]
	patches_out = String[]

	for i=1:npatch	
	
 		p_out=join([patch_out i])
		push!(list, patch_list(patches[i],p_out,param_f,functions))
		push!(patches_out,p_out)
	end

	a = pmap(MyProcess,list)

    SeisUnPatch(patches_out,out;nt=extent.n1,param_patch...)
 
	if rm==1
		for ipatch = 1 : npatch
		SeisRemove(patches[ipatch])
		SeisRemove(patches_out[ipatch])
		end
	end


end




function MyProcess(params)

	f = params.functions
	p = params.param_f
	
	d1,h1,e1 = SeisRead(params.p_file)
    
	for ifunc = 1 : length(f)
		func = f[ifunc]
		d2 = func(d1;p[ifunc]...)
		d1 = copy(d2)
	#h1 = copy(h2)
	end

	SeisWrite(params.p_out,d1,h1,e1)
	return(1)
    
end

mutable struct patch_list
       p_file
       p_out
       param_f
       functions
end