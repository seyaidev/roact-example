-- Interface Controller
-- oniich_n
-- November 24, 2020


-- create a pokedex using roact and rodux! new pokemon create new entries in the dex via rodux

local InterfaceController = {}

function InterfaceController:CreateStore()
    local function pokedexReducer(state, action)
        state = state or {}

        if action.type == "NewEntry" then
            local newState = {}
            print(state)
            for index, entry in ipairs(state) do
                newState[index] = entry
            end
            if not table.find(newState, action.entryNo) then
                table.insert(newState, action.entryNo)
                table.sort(newState)
            end
            return newState
        end

        return state
    end

    local function displayReducer(state, action)
        state = state or 0

        if action.type == "DisplayEntry" then
            return action.entryNo
        end

        return state
    end
    
    local reducer = Rodux.combineReducers({
        pokedexEntries = pokedexReducer,
        displayedEntry = displayReducer,
    })
    self._store = Rodux.Store.new(reducer, nil, {
        Rodux.loggerMiddleware
    })

    self._store:dispatch({
        type = "NewEntry",
        entryNo = 1
    })
end

function InterfaceController:Start()
    -- mount ui
    self:CreateStore()

    self._app = Roact.createElement(RoactRodux.StoreProvider, {
        store = self._store,
    }, {
        Main = Roact.createElement("ScreenGui", {}, {
            Roact.createElement(PokedexFrame)
        })
    })

    local handle = Roact.mount(self._app, PlayerGui, "Pokedex")
end


function InterfaceController:Init()
    PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    ReplicatedStorage = game:GetService("ReplicatedStorage")
    Roact = require(ReplicatedStorage.RoactSrc:WaitForChild("Roact"))
    RoactRodux = require(ReplicatedStorage.RoactSrc:WaitForChild("RoactRodux"))
    Rodux = require(ReplicatedStorage.RoactSrc:WaitForChild("Rodux"))

    PokedexFrame = require(ReplicatedStorage.RoactSrc.Components:WaitForChild("PokedexFrame"))
end


return InterfaceController