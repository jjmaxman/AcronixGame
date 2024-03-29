local module = {}
module.ReplicatedStorage = game:GetService("ReplicatedStorage")
module.ServerScriptService = game:GetService("ServerScriptService")
module.ServerStorage = game:GetService("ServerStorage")
module.Players = game:GetService("Players")
module.StarterGui = game:GetService("StarterGui")
module.UserInputService = game:GetService("UserInputService")
module.RunService = game:GetService("RunService")
module.TweenService = game:GetService("TweenService")
module.CollectionService = game:GetService("CollectionService")
module.SoundService = game:GetService("SoundService")
module.TeleportService = game:GetService("TeleportService")
module.MarketPlaceService = game:GetService("MarketplaceService")
module.Remotes = module.ReplicatedStorage.Remotes
module.KeyBindRemotes = module.Remotes.KeyBindRemotes
module.ChangeKeyBind = module.KeyBindRemotes.ChangeKeyBind
module.GuiModules = module.ReplicatedStorage.GuiModules
module.GuiTemplates = module.ReplicatedStorage.GuiTemplates
module.KeyBindTemplates = module.GuiTemplates.KeybindTemplate
module.MainModule = module.GuiModules.MainModule
module.Utilities = module.ReplicatedStorage.Utilites
module.ErrorMessageCreator = module.Utilities.ErrorMessageCreator
module.Click = module.SoundService.Click
module.Hover = module.SoundService.Hover
module.BoolSettingsTemplate = module.GuiTemplates.BoolSettingsTemplate
module.ConstrainedIntSettingsTemplate = module.GuiTemplates.ConstrainedIntSettingsTemplate
module.ConstrainedDoubleSettingsTemplate = module.GuiTemplates.ConstrainedDoubleSettingsTemplate
module.SeperatorTemplate = module.GuiTemplates.SeperatorTemplate
module.SettingsRemotes = module.Remotes.SettingsRemotes
module.ChangeSettings = module.SettingsRemotes.ChangeSettings
module.Math = {
	["Round"] = function(Number: number, Digits: number, Multiples: number)
		local Num = math.round(Number * 10^Digits) / 10^Digits
		if Multiples then Num = math.round(Num / Multiples) * Multiples end
		return Num
	end
}
module.CameraPart = workspace.CameraPart
module.CurrentCamera = workspace.CurrentCamera
module.Maps = module.ReplicatedStorage.Maps
module.DevMap = module.Maps
module.DeploymentTemplate = module.GuiTemplates.DeploymentTemplate
module.DevProductTemplate = module.GuiTemplates.DevProductTemplate
return module
