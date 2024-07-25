#From USGS, National Petroleum Reserve - Alaska Data Archive
#https://energy.usgs.gov/GeochemistryGeophysics/SeismicDataProcessingInterpretation/NPRASeismicDataArchive.aspx#3862174-data-

download_if_needed("https://saigfileserver.physics.ualberta.ca/static/Datasets/Testing/16_81_PT1_PR.SGY", "16_81_PT1_PR.SGY", sha256sum="54791e8626215d36f6ebcecc3039da2fd74f3472518f47d8e8137c81c2ccfc2f")

SegyToSeis("16_81_PT1_PR.SGY","16_81_PT1_PR")
d,h,ext = SeisRead("16_81_PT1_PR")
imx = SeisMain.ExtractHeader(h,"imx")
println("size(d)=",size(d))
println("imx=",imx)
SeisWrite("16_81_PT1_PR_copy",d,h,ext)

for file in (
             "16_81_PT1_PR",
             "16_81_PT1_PR.SGY",
             "16_81_PT1_PR@data@",
             "16_81_PT1_PR@headers@",
             "16_81_PT1_PR_copy",
             "16_81_PT1_PR_copy@data@",
             "16_81_PT1_PR_copy@headers@",
            )
    rm(joinpath(@__DIR__, file))
end
