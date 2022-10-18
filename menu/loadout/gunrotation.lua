

local menu = require(script.Parent.Parent).GetMenu()
local rs = game:GetService('RunService')
local uis = game:GetService('UserInputService')
local rotpart = workspace:WaitForChild('menuscene').Posing.Weapon
local mouse = game.Players.LocalPlayer:GetMouse()

local click = false
local dx,dy = 0,0
local sensitivity = 0.1

rs.RenderStepped:Connect(function()
	local gun = workspace.CurrentCamera:FindFirstChild('MenuGun')
	if menu.menus.loadout.Visible == false or gun == nil then return end
	
	local mcf = gun:GetPrimaryPartCFrame()
	
	if click == true then
		uis.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
		local delta = uis:GetMouseDelta()
		dx += delta.Y * sensitivity
		dy += delta.X * sensitivity
		
		gun:SetPrimaryPartCFrame(mcf:Lerp(CFrame.new(mcf.Position)* CFrame.fromOrientation(math.rad(dx),math.rad(dy),0),.25))
		
	elseif click == false then
		uis.MouseBehavior = Enum.MouseBehavior.Default
		gun:SetPrimaryPartCFrame(mcf:Lerp(rotpart.CFrame,0.1))
	end
end)

function tween(obj,inf,to)
	local t = game:GetService('TweenService'):Create(obj,TweenInfo.new(inf,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),to)
	t:Play()
end

mouse.Button2Down:Connect(function()
	click = true
end)


mouse.Button2Up:Connect(function()
	click = false
end)

mouse.WheelBackward:Connect(function()
	if menu.menus.loadout.Visible == false or workspace.CurrentCamera:FindFirstChild('MenuGun') == nil then return end
	
	local t = workspace.CurrentCamera.FieldOfView+3
	t = math.clamp(t,8,120)
	tween(workspace.CurrentCamera,.03,{FieldOfView = t})
	
end)

mouse.WheelForward:Connect(function()
	if menu.menus.loadout.Visible == false or workspace.CurrentCamera:FindFirstChild('MenuGun') == nil then return end

	local t = workspace.CurrentCamera.FieldOfView-3
	t = math.clamp(t,8,120)
	tween(workspace.CurrentCamera,.03,{FieldOfView = t})
	
end)