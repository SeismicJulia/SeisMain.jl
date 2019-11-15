# Package guide

SeisMain.jl provides seismic data reading, writing and handling tools. 
Format conversion is available between SEIS data and SEGY, and SU.

With SeisMain.jl installed we can do a simple example showing format conversion

```julia
using SeisMain, SeisPlot
run(`mkdir -p data`)
download("http://seismic.physics.ualberta.ca/data/616_79_PR.SGY", "data/616_79_PR.SGY")
SegyToSeis("data/616_79_PR.SGY", "data/616_79_PR.seis")
SeisWindow("data/616_79_PR.seis", "data/616_79_PR_2s.seis", key= ["t"], minval=[0.0], maxval=[2.0])
d, head, extent = SeisRead("data/616_79_PR_2s.seis")

SeisPlotTX(d, title="Seismic Plot Example", cmap="PuOr", wbox=9,ylabel="Time(s)",xlabel="Trace Number(index)",dy=extent.d1)
```

![plot1](http://seismic.physics.ualberta.ca/figures/616_79_PR2.png)

In the above example, we first download the data, then convert the data from SU data format to SEIS format, finally the data are plotted. 
