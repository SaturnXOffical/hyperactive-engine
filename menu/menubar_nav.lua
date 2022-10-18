

local menu = require(script.Parent).GetMenu()

local bar,selcir = menu.bar,menu.bar.selblock

function tween(obj,inf,to)
	local t = game:GetService('TweenService'):Create(obj,TweenInfo.new(inf,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut,0,false,0),to)
	t:Play()
end

for i,v in pairs(bar.list:GetChildren()) do 
	if not v:IsA('TextButton') then return end
	
	v.MouseButton1Click:Connect(function()
		local pass = true
		
		if menu.menus:FindFirstChild(v.Name) then
			local ui = menu.menus:FindFirstChild(v.Name)
			if v:FindFirstChild('unavail') then
				pass = false
			end
		else 
			pass = false
		end
		
		if pass == false then return end
		
		tween(selcir,.5,{Position = UDim2.new(0,v.AbsolutePosition.X,0.5,0)})
		tween(workspace.CurrentCamera,.5,{CFrame = workspace.menuscene.Cameras[v.Name].CFrame})
		tween(workspace.CurrentCamera,.5,{FieldOfView = 70})
		
		for o,l in pairs(menu.menus:GetChildren()) do 
			l.Visible = false
		end
		
		local ui = menu.menus:FindFirstChild(v.Name)
		
		ui.Visible = true
		
	end)
end

print("Menu_Navigation: Ready")