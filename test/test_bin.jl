println("Testing test_bin.jl")

download_if_needed("https://saigfileserver.physics.ualberta.ca/static/Datasets/Testing/prestack_section.su", "section.su", sha256sum="8baaf281a36dcd5656e07e728bf97e0c1b513302b12206efbb24c3edb34d9ec8");

SegyToSeis("section.su","section",format="su",input_type="ieee");

param1 = Dict( :dmx=>15, :dmy=>15, :dh=>30, :daz=>45 );

param2 = Dict(:style=>"mxmyhaz", :min_imx=>10,:max_imx=>100, :min_imy=>35, :max_imy=>45,
               :min_ih=>1, :max_ih=>6, :min_iaz=>0, :max_iaz=>7);

SeisGeometry("section"; param1...)

SeisBinHeaders("section","section_bin"; param1..., param2...);

SeisBinData("section","section_bin"; param1..., param2...);

db,hb,eb=SeisRead("section_bin");

N =size(db)

@test N == (251, 91, 11, 6, 8)

for file in (
             "section",
             "section@data@",
             "section@headers@",
             "section.su",
            )
    rm(joinpath(@__DIR__, file))
end
