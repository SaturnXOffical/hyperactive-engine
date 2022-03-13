local module = {}

--[[
	
	Hyperactive Engine
	Engine Fake Kernel

	The fake kernel is the script representing common issues and solutions to the rest of the engine.
	Similar to an OS Kernel, the fake kernel handles situations such as mathematics and panics.
	
	Panics are when a servere issue occurs and the engine needs to shut down.

	Last updated: 12/4/2021 by SaturnDev

--]]

local plr = game.Players.LocalPlayer

function module.Panic(msg, errcode)
	-- *engine hyperventilating noises*
	
	local ui = script.Parent.Parent.Parent
	ui:WaitForChild("HUD").Enabled = false
	ui:WaitForChild("Menu").Enabled = false
	ui:WaitForChild("Loading").Enabled = false
	-- engine kills chat and notif system
	
	local g = Instance.new("ScreenGui")
	g.Parent = script.Parent.Parent.Parent
	g.Name = "EnginePanic"
	g.Enabled = true
	local l = Instance.new("Frame")
	l.Parent = g
	l.ZIndex = 999999
	l.Size = UDim2.new(1, 1,1.167, 1)
	l.BackgroundColor3 = Color3.new(0.776471, 0, 0)
	l.BackgroundTransparency = 0
	l.Visible = true
	l.Position = UDim2.new(-0.001, 0,-0.168, 0)
	
	warn(msg)
	plr:Kick("Hyperactive Engine: Fake Kernel PANIC (A severe has error occured, and the game has stopped working.) | "..msg.." | ERR. #"..errcode.." | Do not go panic posting on discord! Sometimes the answer is directly in front of you!")
	
	while true do
		ui:WaitForChild("HUD").Enabled = false
		ui:WaitForChild("Menu").Enabled = false
		ui:WaitForChild("Loading").Enabled = false
		g.Enabled = true
		wait(0.05)
	end
end

return module
