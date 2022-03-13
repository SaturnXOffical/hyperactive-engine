local module = {}

--[[

    Hyperactive Engine
    Reticle Rendering System

    The reticle renderer is in charge of rendering a 3D Gui representation of the sight on a scope.
    This replaced the original system of a billboardgui placed within the scope. This billboardgui can still be seen within the menu.

    There is a similar (alpha) experiment where we rewrite roblox's entire Rendering system to support multi-camera rendering (aka dual rendering)
    This will let us achieve scope systems similar to ones in Call of Duty: Warzone and Battlefield 2042.
	Yet Phantom Forces achieves this better (also gui based)

    Last updated: 2/1/2022 by ThreeBytesAShy

--]]

local msg = script.Parent.Parent.MenuSelectedGun
local rs = game:GetService("RunService")
local hud = script.Parent.Parent.Parent:WaitForChild("HUD")
local ui = hud.ReticleRender.RenderCenter.RenderZone  -- set up like this so the ui only fits in a certain square

-- Note to self: try to make it resize & reposition the sight to fit the actual sight

local ret = nil
local renderpart = nil

--local doRender = false

function avgSub(num,unit)
	return (num - ui.AbsolutePosition[unit]) + 2
	-- sight renderer needs to be scaled to the frame size to actually work
end

function module.UpdateRenderAttachment(a)
	--doRender = true
	ui:ClearAllChildren()
	local img = script.Template:Clone()
	img.Name = a.Name
	local gui =  a["SightMark"]["SurfaceGui"]
	
	if gui:FindFirstChild("Border") then
		gui = gui["Border"]["Scope"]
	else
		gui = gui["ImageLabel"]
	end
	
	gui.Visible = false
	
	img.Template.Image = gui.Image 
	img.Template.ImageColor3 = gui.ImageColor3
	img.Parent = ui 
	
	if a:FindFirstChild("RenderPart") then 
		renderpart = a["RenderPart"]
	else 
		renderpart = a["FirePart"]
	end
	
	ret = img
	img.Visible = true
end

rs.RenderStepped:Connect(function()
	if msg.isDeployed.Value == true  then
		if ret ~= nil and renderpart ~= nil then
			local vector, isVisible = workspace.CurrentCamera:WorldToScreenPoint(renderpart.Position)

			--if isVisible == true then
			ret.Visible = msg.isAiming.Value
			--ui.ClipsDescendants = false
--			ret.Visible = true

			local sp = Vector2.new(
				vector.X, 
				vector.Y
			)

            -- make slower in future, try to make less janky and limit the area it can go to as well
			ret.Position = ret.Position:Lerp(UDim2.new(0,avgSub(sp.X,'X'),0,avgSub(sp.Y,"Y")),0.4)
			-- needa update the git rep to include the boundary system lmao
		end
		
	else 
		if ret ~= nil then ret:Destroy() end
		ret = nil
		renderpart = nil
		--doRender = false
	end	
end)

return module
