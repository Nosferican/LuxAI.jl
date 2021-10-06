"""
    GameConstants(jsonfile::AbstractString = joinpath(pkgdir(LuxAI), "src", "lux", "game_constants.json"))

This will contain constants on all game parameters like the max turns, the light upkeep of CityTiles etc.
If there are any crucial changes to the starter kits, typically only this object will change.
"""
struct GameConstants
    DAY_LENGTH :: Int
    NIGHT_LENGTH :: Int
    MAX_DAYS :: Int
    LIGHT_UPKEEP :: NamedTuple{(:CITY, :WORKER, :CART), NTuple{3, Int}}
    WOOD_GROWTH_RATE :: Float64
    MAX_WOOD_AMOUNT :: Int
    CITY_BUILD_COST :: Int
    CITY_ADJACENCY_BONUS :: Int
    RESOURCE_CAPACITY :: NamedTuple{(:WORKER, :CART), NTuple{2, Int}}
    WORKER_COLLECTION_RATE :: NamedTuple{(:WOOD, :COAL, :URANIUM), NTuple{3, Int}}
    RESOURCE_TO_FUEL_RATE :: NamedTuple{(:WOOD, :COAL, :URANIUM), NTuple{3, Int}}
    RESEARCH_REQUIREMENTS :: NamedTuple{(:COAL, :URANIUM), NTuple{2, Int}}
    CITY_ACTION_COOLDOWN :: Int
    UNIT_ACTION_COOLDOWN :: NamedTuple{(:WORKER, :CART), NTuple{2, Int}}
    MAX_ROAD :: Int
    MIN_ROAD :: Int
    CART_ROAD_DEVELOPMENT_RATE :: Float64
    PILLAGE_RATE :: Float64
    function GameConstants(jsonfile::AbstractString = joinpath("src", "lux", "game_constants.json"))
        # jsonfile = joinpath(@__DIR__, "src", "lux", "game_constants.json")
        json = JSON3.read(read(jsonfile, String))
        @unpack DAY_LENGTH, NIGHT_LENGTH, MAX_DAYS, LIGHT_UPKEEP, WOOD_GROWTH_RATE, MAX_WOOD_AMOUNT,
            CITY_BUILD_COST, CITY_ADJACENCY_BONUS, RESOURCE_CAPACITY, WORKER_COLLECTION_RATE,
            RESOURCE_TO_FUEL_RATE, RESEARCH_REQUIREMENTS, CITY_ACTION_COOLDOWN,
            UNIT_ACTION_COOLDOWN, MAX_ROAD, MIN_ROAD, CART_ROAD_DEVELOPMENT_RATE, PILLAGE_RATE =
            json.PARAMETERS
        LIGHT_UPKEEP = NamedTuple(pn => getproperty(LIGHT_UPKEEP, pn) for pn in [:CITY, :WORKER, :CART])
        RESOURCE_CAPACITY = NamedTuple(pn => getproperty(RESOURCE_CAPACITY, pn)
                                       for pn in [:WORKER, :CART])
        WORKER_COLLECTION_RATE = NamedTuple(pn => getproperty(WORKER_COLLECTION_RATE, pn)
                                            for pn in [:WOOD, :COAL, :URANIUM])
        RESOURCE_TO_FUEL_RATE = NamedTuple(pn => getproperty(RESOURCE_TO_FUEL_RATE, pn)
                                           for pn in [:WOOD, :COAL, :URANIUM])
        RESEARCH_REQUIREMENTS = NamedTuple(pn => getproperty(RESEARCH_REQUIREMENTS, pn)
                                           for pn in [:COAL, :URANIUM])
        UNIT_ACTION_COOLDOWN = NamedTuple(pn => getproperty(UNIT_ACTION_COOLDOWN, pn)
                                          for pn in [:WORKER, :CART])
        new(DAY_LENGTH, NIGHT_LENGTH, MAX_DAYS, LIGHT_UPKEEP, WOOD_GROWTH_RATE, MAX_WOOD_AMOUNT,
            CITY_BUILD_COST, CITY_ADJACENCY_BONUS, RESOURCE_CAPACITY, WORKER_COLLECTION_RATE,
            RESOURCE_TO_FUEL_RATE, RESEARCH_REQUIREMENTS, CITY_ACTION_COOLDOWN,
            UNIT_ACTION_COOLDOWN, MAX_ROAD, MIN_ROAD, CART_ROAD_DEVELOPMENT_RATE, PILLAGE_RATE)
    end
end

const GAME_CONSTANTS = GameConstants()
