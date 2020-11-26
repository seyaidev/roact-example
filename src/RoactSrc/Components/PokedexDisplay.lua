-- Renders display when clicking a new entry

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.RoactSrc:WaitForChild("Roact"))
local RoactRodux = require(ReplicatedStorage.RoactSrc:WaitForChild("RoactRodux"))

local defaultCorner  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("DefaultCorner"))
local PokemonInfo  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("PokemonInfo"))

local pokedexDisplay = Roact.Component:extend("PokedexDisplay")

function pokedexDisplay:render()
    local entryNo = self.props.entryNo
    local monfo 
    if self.props.entryNo > 0 then
        monfo = PokemonInfo[entryNo]
    else
        monfo = {
            Name = "",
            Image = ""
        }
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(235, 214, 157),

        Visible = monfo.Name ~= ""
    }, {
        Corner = defaultCorner,
        Image = Roact.createElement("ImageLabel", {
            Size = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0.1, 0),
            BackgroundTransparency = 1,

            Image = monfo.Image,
        }, {
            Aspect = Roact.createElement("UIAspectRatioConstraint")
        }),

        Name = Roact.createElement("TextLabel", {
            Size = UDim2.new(0.5, 0, 0.1, 0),
            Position = UDim2.new(0.5, 0, 0.8, 0),
            BackgroundTransparency = 0.5,
            Font = Enum.Font.GothamBold,
            TextScaled = true,
            TextColor3 = Color3.new(1,1,1),
            BackgroundColor3 = Color3.new(),
            AnchorPoint = Vector2.new(0.5),

            Text = "#" .. tostring(entryNo) .. ": " .. monfo.Name,
        }, {
            Corner = defaultCorner
        })
    })
end

return RoactRodux.connect(
    function(state)
        return {
            entryNo = state.displayedEntry
        }
    end
)(pokedexDisplay)