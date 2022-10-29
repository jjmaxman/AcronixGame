local globals = require(game:GetService("ReplicatedStorage").Globals)

local module = {}
module.LoadModule = function()
	globals.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	
	globals.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	globals.CurrentCamera.CFrame = globals.CameraPart.CFrame
end
return module
