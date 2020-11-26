-- Aaron Adriano

-- Renders main frame for pokedex

math.randomseed(os.time())

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.RoactSrc:WaitForChild("Roact"))
local RoactRodux = require(ReplicatedStorage.RoactSrc:WaitForChild("RoactRodux"))

local defaultCorner  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("DefaultCorner"))
local pokedexEntries  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("PokedexEntries"))
local pokedexDisplay  = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("PokedexDisplay"))


local pokedexFrame = Roact.Component:extend("PokedexFrame")

function pokedexFrame:render()
    local getPokemon = self.props.getPokemon
    local children = {}

    children["Corner"] = defaultCorner
    children["Padding"] = Roact.createElement("UIPadding", {
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        PaddingTop = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15),
    })

    children["CatchButton"] = Roact.createElement("TextButton", {
        Size = UDim2.new(0.2, 0, 0, 50),
        BackgroundColor3 = Color3.new(0,0,0),
        TextColor3 = Color3.new(1,1,1),
        Position = UDim2.new(0.5, 0, 1, 30),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 0.5,
        Font = Enum.Font.GothamBold,
        TextScaled = true,
        Text = "Catch Pokemon",

        [Roact.Event.Activated] = getPokemon
    })
    
    local totalEntries = #self.props.entries
    local canvasSizeOverride = (80 * totalEntries) -- AutomaticCanvasSize isn't working for some reason..
    children["ScrollingFrame"] = Roact.createElement("ScrollingFrame", {
        Size = UDim2.new(0.5, 0, 1, 0),
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(0, 0, 0, canvasSizeOverride)
    }, {
        Layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10)
        }),
        
        ListEntries = Roact.createElement(pokedexEntries),
    })

    children["PokedexDispay"] = Roact.createElement(pokedexDisplay)

    return Roact.createElement("Frame", {
        Size = UDim2.new(0.6, 0, 0.4),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, children)
end

return RoactRodux.connect(
    function(state)
        return {
            entries = state.pokedexEntries,
        }
    end,
    function(dispatch)
        return {
            getPokemon = function()
                dispatch({
                    type = "NewEntry",
                    entryNo = math.random(1, 24)
                })
            end
        }
    end
)(pokedexFrame)