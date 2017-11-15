function paste_eval()
    include_string(clipboard())
end

if isfile("projector.jl")
    include(realpath("$(pwd())/projector.jl"))
end
