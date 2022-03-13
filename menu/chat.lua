
--[[

    Hyperactive Engine
    Chat System

    Pretty self explanitory
    Allows players to chat with other players in the same server

	The server tips are pushed through the standard message event by the server

    Last updated 1/25/2022 by ThreeBytesAShy

--]]

function tween(obj, info, to)
	local ts = game:GetService("TweenService")
	local tweeninf = TweenInfo.new(
		info,
		Enum.EasingStyle.Cubic,
		Enum.EasingDirection.Out,

		-- dont edit the three below
		0,
		false,
		0
	)
	local tween = ts:Create(obj, tweeninf, to)
	tween:Play()
end

function ftween(obj, info, to)

    -- why do we do this JUST to return a tween? just add a boolean to the tween function  
    -- i dont think this even gets used lol

	local ts = game:GetService("TweenService")
	local tweeninf = TweenInfo.new(
		info,
		Enum.EasingStyle.Cubic,
		Enum.EasingDirection.Out,

		-- dont edit the three below
		0,
		false,
		0
	)
	local tween = ts:Create(obj, tweeninf, to)
	tween:Play()

	return tween
end

local chatTags = {
    -- uses RGB formats
	["SaturnXOffical"] = {
		"Dev",
		'55,255,68'--Color3.fromRGB(55, 255, 68)
	},
	["crabfg"] = {
		"Tester",
		'0,243,255'--.fromRGB(0, 243, 255)
	}
}

local ui = script.Parent.Parent.Parent:WaitForChild("EngineChat")
local uis = game:GetService("UserInputService")
local chat = ui.GlobalChat
local dist = UDim2.new(0,0,-0.2,0)
local hassent = false
local spamcheck = script.spamcheck
local blockcheck = script.isblocked
local listcount = 0
ui.Version.Text = "[CLOSED TESTING] Alpha version: "..tostring(script.Parent.Parent.Parent.Changelog.build.Value)
chat.Template.Visible = false

game.ReplicatedStorage.Events.ServerChatMsg.OnClientEvent:Connect(function(msg)
	for i, item in pairs(chat:GetChildren()) do 
		if item.Name ~= "Template" then
			item.Name = tonumber(item.Name) + 1
			if tonumber(item.Name) < 6 then
				tween(item, 0.5, {Position = item.Position + dist})
			elseif tonumber(item.Name) >= 6 then
				item:Destroy()
			end
		end
	end

	local nmsg = chat.Template:Clone()
	nmsg.Position = chat.Template.Position - dist
	nmsg.Parent = chat
	local col = Color3.new(0.337255, 0.337255, 0.337255)

	col = tostring(math.floor(col.R*255)..",".. math.floor(col.G*255)..","..math.floor(col.B*255))

	nmsg.Text = '<font color="rgb('..tostring(col)..')"><font face="SourceSansSemibold">Console</font></font>: '..msg
	nmsg.TextTransparency = 1

	nmsg.Visible = true


	tween(nmsg, 0.5, {Position = chat.Template.Position})
	tween(nmsg, 0.35, {TextTransparency = 0})
	nmsg.Name = tostring(0)
end)

game.ReplicatedStorage.Events.Message.OnClientEvent:Connect(function(sender,msg)
	for i, item in pairs(chat:GetChildren()) do 
		if item.Name ~= "Template" then
			item.Name = tonumber(item.Name) + 1
			if tonumber(item.Name) < 6 then
				tween(item, 0.5, {Position = item.Position + dist})
			elseif tonumber(item.Name) >= 6 then
				item:Destroy()
			end
		end
	end
	
	local nmsg = chat.Template:Clone()
	nmsg.Position = chat.Template.Position - dist
	nmsg.Parent = chat
	local col 
	
	if sender.Team == game.Teams.Mavericks then
		col = ui.TeamColors.ColMavericks.Value
	elseif sender.Team == game.Teams.Falcons then
		col = ui.TeamColors.ColFalcons.Value
	end
	
	col = tostring(math.floor(col.R*255)..",".. math.floor(col.G*255)..","..math.floor(col.B*255))
	
	if chatTags[sender.Name] then
		nmsg.Text = '<font color="rgb('..tostring(chatTags[sender.Name][2])..')">['..chatTags[sender.Name][1]..']</font> <font color="rgb('..tostring(col)..')"><font face="SourceSansSemibold">'..tostring(sender.Name)..'</font></font>: '..msg
	else
		nmsg.Text = '<font color="rgb('..tostring(col)..')"><font face="SourceSansSemibold">'..tostring(sender.Name)..'</font></font>: '..msg
	end
	
	nmsg.TextTransparency = 1
	
	nmsg.Visible = true
	
	
	tween(nmsg, 0.5, {Position = chat.Template.Position})
	tween(nmsg, 0.35, {TextTransparency = 0})
	nmsg.Name = tostring(0)
	
end)

uis.InputBegan:Connect(function(keycode)
	local key = keycode.KeyCode
	
	if hassent == false and key == Enum.KeyCode.Return and ui.TextBox.Text ~= nil and ui.TextBox.Text ~= " " and ui.TextBox.Text ~= "" and script.isblocked.Value == false and ui.TextBox.Visible == true and ui.Warn.Visible == false and script.Parent.Parent.MenuSelectedGun.isDeployed.Value == false then
		hassent = true
		spamcheck.Value = spamcheck.Value + 1
		game.ReplicatedStorage.Events.Message:FireServer(game.Players.LocalPlayer, tostring(ui.TextBox.Text))
		wait()
		ui.TextBox.Text = ""
		wait(0.001)
		hassent = false
	end
end)