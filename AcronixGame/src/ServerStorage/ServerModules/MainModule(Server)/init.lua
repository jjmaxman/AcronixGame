--Server Script--

local server = script.Server
local data = script.Data

local function LoadRequestedModules(ModuleFolder: Folder)
	for _, module in ipairs(ModuleFolder:GetChildren()) do
		local currentModule = require(module)
		currentModule.LoadModule()
	end
end

local main = {}
main.LoadServerModules = function()
	LoadRequestedModules(server)
	LoadRequestedModules(data)
end
return main
