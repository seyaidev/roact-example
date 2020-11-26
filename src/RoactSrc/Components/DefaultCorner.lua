local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.RoactSrc:WaitForChild("Roact"))

return Roact.createElement("UICorner", {
    CornerRadius = UDim.new(0, 15)
})