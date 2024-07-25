param2 = Dict(:style=>"mxmyhaz", :min_imx=>10,:max_imx=>100, :min_imy=>35, :max_imy=>45,
               :min_ih=>1, :max_ih=>6, :min_iaz=>0, :max_iaz=>7);

param3 = Dict( :ix1_WL=>30,:ix1_WO=>5);

file_bin="section_bin"           # Run first Demo_Utils_1_Binning.ipynb
patch_out="patch"                # will make files patch1, patch2,....
file_final ="section_bin_final"  # file put back from patches via code SeisUnPatch

patch_out,npatch=SeisPatch(file_bin,"patch"; param2...,param3... );

SeisUnPatch(patch_out,file_final; param2...,param3...,nt=251);

db,hb,eb=SeisRead(file_bin);

df,hf,ef=SeisRead(file_final);

alpha = maximum(db-df)

@test alpha < 0.1

for file in (
             "section_bin",
             "section_bin_final",
             "patch_1",
             "patch_2",
             "patch_3",
             "patch_4",
            )
    rm(joinpath(@__DIR__, file))
    rm(joinpath(@__DIR__, file*"@data@"))
    rm(joinpath(@__DIR__, file*"@headers@"))
end
