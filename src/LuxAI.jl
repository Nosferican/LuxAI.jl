module LuxAI

using Parameters: Parameters, @unpack
using JSON3: JSON3

for file in ["annotate", "constants", "game_objects", "game"]
    include(joinpath("src", "lux", "$file.jl"))
    # println(joinpath("src", "lux", "$file.jl"), isfile(joinpath("src", "lux", "$file.jl")))
end

end
