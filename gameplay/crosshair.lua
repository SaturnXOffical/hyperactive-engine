local module = {}

local ui = script.Parent.Parent.Parent:WaitForChild('HUD'):WaitForChild('Crosshair')
local lerp = .2

function format(x,side)
	local r = UDim2.new(0,0,0,0)
	
	if side == "L" then
		r = UDim2.new(0.5,-x,.5,0)
	elseif side == 'R' then
		r = UDim2.new(0.5,x,.5,0)
	elseif side == 'B' then
		r = UDim2.new(0.5,0,0.5,x)
	elseif side == 'T' then
		r = UDim2.new(0.5,0,0.5,-x)
	end
	
	return r
end

function module.update(input)
	local target = 100  -- defaults in case for some reason something wont work
	
	if input.Aim == true then
		target = 1
	elseif input.Sprint == true then
		target = 300
	elseif input.Walk == true then
		target = 170
	else 
		target = 90
	end
	
	ui.L.Position = ui.L.Position:Lerp(format(target,'L'),lerp)
	ui.R.Position = ui.R.Position:Lerp(format(target,'R'),lerp)
	ui.B.Position = ui.B.Position:Lerp(format(target,'B'),lerp)
	ui.T.Position = ui.T.Position:Lerp(format(target,'T'),lerp)
	
end

return module
