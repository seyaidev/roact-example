-- boilerplate aero roact module

local MyComponent = {}

function MyComponent:GetComponent()
    
end

function MyComponent:Init()
    Roact = self.Modules.Roact
    RoactRodux = self.Shared.RoactRodux

end

return MyComponent