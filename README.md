<a name="logo"/>
<div align="center">
<a href="http://saig.physics.ualberta.ca/" target="_blank">
<img src="https://saig.physics.ualberta.ca/lib/tpl/dokuwiki/images/logo.png" alt="SAIG Logo" width="240" height="106"></img>
</a>
</div>

# SeisMain.jl

[![Build Status](https://travis-ci.com/SeismicJulia/SeisMain.jl.svg?branch=master)](https://travis-ci.com/SeismicJulia/SeisMain.jl)

This package contains tools to handle seismic data with the Seis format.

At the moment, it is updated and tested against Julia v1.

## Installation

To use this package you must first install the [Julia](http://julialang.org/downloads/) programming language.
Then, run the Julia application and type, at the prompt

```julia>using Pkg

julia>Pkg.add("https://github.com/SeismicJulia/SeisMain.jl.git")

julia>using SeisMain```

If you use the SeismicJulia project, please cite the following paper
```
@article{stanton2016efficient,
  title={Efficient geophysical research in Julia},
  author={Stanton, Aaron and Sacchi, Mauricio D},
  journal={CSEG GeoConvention 2016},
  pages={1--3},
  year={2016}
}
```

## Basic usage
For SeisPlot, please refer [here](https://github.com/SeismicJulia/SeisPlot.jl).

The following example produces the figure below.
```Julia
using SeisMain
using SeisPlot 
run(`mkdir -p data`)
download("http://seismic.physics.ualberta.ca/data/616_79_PR.SGY", "data/616_79_PR.SGY")
SegyToSeis("data/616_79_PR.SGY", "data/616_79_PR.seis")
SeisWindow("data/616_79_PR.seis", "data/616_79_PR_2s.seis", key= ["t"], minval=[0.0], maxval=[2.0])
d, head, extent = SeisRead("data/616_79_PR_2s.seis")

SeisPlotTX(d, title="Seismic Plot Example", cmap="PuOr", wbox=9,ylabel="Time(s)",xlabel="Trace Number (index)",dy=extent.d1)

```

![plot1](http://seismic.physics.ualberta.ca/figures/616_79_PR2.png)

## For developers: contributing to the project

* New at GitHub? These [basic commands](http://seismic.physics.ualberta.ca/docs/git_basic_commands.pdf)
and this [dictionary](http://seismic.physics.ualberta.ca/docs/git_dictionary.pdf) might help.
* This [tutorial](http://seismic.physics.ualberta.ca/docs/develop_SeismicJulia.pdf) provides the basics
steps you need to follow in order to fork the main repository, change the source code in your forked
repository, commit the changes, and make pull requests using GitHub.
* For contributions to the package, please follow the general guidelines given here:
[Modifications.md](https://github.com/SeismicJulia/Seismic.jl/blob/master/Modifications.md).
