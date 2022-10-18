local module = {}

function module.run(strengthx,strengthy)
	game['Run Service'].RenderStepped:Wait()
	local randy = (math.random(0,strengthy*2)-strengthy)/1200
	if workspace.CurrentCamera.CFrame.LookVector.Y < 0.9 then
		workspace.CurrentCamera.CFrame *=CFrame.Angles(strengthx/360/2,randy/4,0)
		game['Run Service'].RenderStepped:Wait()
		workspace.CurrentCamera.CFrame *= CFrame.Angles(strengthx/360/2,randy/4,0)
	else 
		game['Run Service'].RenderStepped:Wait()
	end
	
	local value = 0
	for i=20,1,-1 do 
		game['Run Service'].RenderStepped:Wait()
		workspace.CurrentCamera.CFrame *= CFrame.Angles(-strengthx/7200*i/14,randy/40*i/10,0)
		value += i/10
	end
end

-- got this from the Roblox Devforum. Thank you sleepingfoxXD for posting the article and CraftMarkus for the code :)

return module
