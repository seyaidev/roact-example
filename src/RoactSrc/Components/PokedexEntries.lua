local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.RoactSrc:WaitForChild("Roact"))
local RoactRodux = require(ReplicatedStorage.RoactSrc:WaitForChild("RoactRodux"))

local defaultCorner  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("DefaultCorner"))
local PokemonInfo  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("PokemonInfo"))

local pokedexEntries = Roact.Component:extend("PokedexEntries")

function pokedexEntries:render()
    local entries = self.props.entries
    local onClick = self.props.onClick

    local entryElements = {}

    for _, entryNo in ipairs(entries) do
        -- create a new entry element
        local monfo = PokemonInfo[entryNo]
        local newEntry = Roact.createElement("TextButton", {
            Text = "#" .. tostring(entryNo) .. ": " .. monfo.Name,
            Size = UDim2.new(0.8, 0, 0, 70),
            TextSize = 20,
            Font = Enum.Font.Gotham,
            BackgroundTransparency = 0.5,
            BackgroundColor3 = Color3.new(),
            TextColor3 = Color3.new(1,1,1),
            LayoutOrder = entryNo,

            [Roact.Event.Activated] = function()
                onClick(entryNo)
            end
        }, defaultCorner)
        table.insert(entryElements, newEntry)
    end
    
    return Roact.createFragment(entryElements)
end

return RoactRodux.connect(
    function(state)
        return {
            entries = state.pokedexEntries
        }
    end,
    function(dispatch)
        return {
            onClick = function(selected)
                dispatch({
                    type = "DisplayEntry",
                    entryNo = selected
                })
            end
        }
    end
)(pokedexEntries)