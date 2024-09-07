module SeisMain
    using Printf
    using Statistics
    using Distributed
    using DataFrames
    include("ReadWrite/ReadWrite.jl")
    include("Utils/Utils.jl")
end
