--Client Script--

local clientModules = script.Client

local function LoadRequestedModules(ModuleFolder: Folder)
	for _, modules in ipairs(ModuleFolder:GetChildren()) do
		local currentModule = require(modules)
		currentModule.LoadModule()
	end
end

local module = {}

module.LoadClientModules = function()
	LoadRequestedModules(clientModules)
end

return module
