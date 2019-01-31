using SeisMain
using Test

download("http://seismic.physics.ualberta.ca/data/prestack_section.su","section.su");

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