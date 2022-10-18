

local rs = game:GetService('RunService')
local gui = require(script.Parent.Parent).GetMenu()
local ui = gui.menus.loadout.Customize
local cam = workspace.CurrentCamera

local offsets = {
	['Optics'] = Vector2.new(25,70),
	['Other'] = Vector2.new(-25,80),
	['Barrel'] = Vector2.new(20,-60),
	['Ammo'] = Vector2.new(100,35),
	['Laser' ] = Vector2.new(-15,-100),
	['Underbarrel'] = Vector2.new(15,-80)
}

function drawPath(Line, startBtn,endBtn)
	local startX, startY = startBtn.X, startBtn.Y
	local endX, endY = endBtn.X,endBtn.Y
	
	Line.AnchorPoint = Vector2.new(0.5, 0.5)
	Line.Size = UDim2.new(0, (((endX - startX) ^ 2 + (endY - startY) ^ 2) ^ 0.5)-25, 0, 5) -- Get the size using the distance formula
	Line.Position = UDim2.new(0, (startX + endX) / 2, 0, (startY + endY) / 2) -- Get the position using the midpoint formula
	Line.Rotation = math.atan2(endY - startY, endX - startX) * (180 / math.pi) -- Get the rotation using atan2, convert radians to degrees
end

function getPos(dot)
	local vec,ons = cam:WorldToScreenPoint(dot.Position)
	return {Pos = Vector2.new(vec.X,vec.Y), OnScreen = ons}
end

function updClampPos (ui2,dot)
	local fetch = getPos(dot)
	local pos = fetch.Pos
	
	local function clampCalc(x,vps)
		return math.clamp(math.floor(x-(vps/2)),-10,10)
	end
	
	ui2.Visible = fetch.OnScreen
	
	ui2.Position = UDim2.new(
		ui2.Position.X.Scale,
		clampCalc(pos.X,workspace.CurrentCamera.ViewportSize.X),
		ui2.Position.Y.Scale,
		clampCalc(pos.Y,workspace.CurrentCamera.ViewportSize.Y)
	)
end

function updCenterPos(ui2,dot)
	local fetch = getPos(dot)
	local pos = fetch.Pos
	
	ui2.Visible = fetch.OnScreen
	
	ui2.Position = UDim2.new(0,pos.X,0,pos.Y)
end

function updOffsetPos(ui2,dot)
	local fetch = getPos(dot)
	local pos = fetch.Pos
	local ofs = offsets[dot.Name]
	
	ui2.Visible = fetch.OnScreen
	
	ui2.Position = UDim2.new(0,pos.X+ofs.X,0,pos.Y+ofs.Y)
end

function scaleToOffset(x,vec)
	return x * vec
end

rs.RenderStepped:Connect(function()
	local gun = workspace.CurrentCamera:FindFirstChild('MenuGun')
	if not gun then return end
	
	for i,v in pairs(ui.dots:GetChildren()) do 
		updCenterPos(v,gun.AttachmentPos:FindFirstChild(v.Name))
	end
	
	for i,v in pairs(ui.labels:GetChildren()) do 
		updClampPos(v,gun.AttachmentPos:FindFirstChild(v.Name))
	end
	
	for i,v in pairs(ui.lines:GetChildren()) do 
		local pos = getPos(gun.AttachmentPos:FindFirstChild(v.Name)).Pos
		local label = ui.labels:FindFirstChild(v.Name)
		drawPath(v,pos,Vector2.new(scaleToOffset(label.Position.X.Scale,workspace.CurrentCamera.ViewportSize.X)+label.Position.X.Offset,scaleToOffset(label.Position.Y.Scale,workspace.CurrentCamera.ViewportSize.Y)+label.Position.Y.Offset))
	end
end)