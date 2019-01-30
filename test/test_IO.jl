using SeisMain

#From USGS, National Petroleum Reserve - Alaska Data Archive
#https://energy.usgs.gov/GeochemistryGeophysics/SeismicDataProcessingInterpretation/NPRASeismicDataArchive.aspx#3862174-data-

download("http://certmapper.cr.usgs.gov/data/NPRA/seismic/1976/125_76/PROCESSED/125_76_PT2_PR.SGY","125_76.SGY")


SegyToSeis("125_76.SGY","125_76")
d,h,ext = SeisRead("125_76")
imx = Seismic.ExtractHeader(h,"imx")
println("size(d)=",size(d))
println("imx=",imx)
SeisWrite("125_76_copy",d,h,e)

