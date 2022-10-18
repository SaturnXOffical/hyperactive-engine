local module = {}

local ui = script.Parent.Parent:WaitForChild('GameChat')

local cols = {Console = '0,255,155', Allegiance = '0,255,0', Coalition = '255,255,0'}
Color3.fromRGB()

local chatTags = {
	
	["Dev"] = {
		TagDisplay = "DEVELOPER",
		TagRGB = Color3.fromRGB(0, 102, 255),
		TagRGBTxt = "0,102,255"
	},
	
	["Yt"] = {
		TagDisplay = "YOUTUBER",
		TagRGB = Color3.fromRGB(255, 29, 29),
		TagRGBTxt = "255,29,29"
	},
	
	["Test"] = {
		TagDisplay = "TESTER",
		TagRGB = Color3.fromRGB(255, 255, 0),
		TagRGBTxt = "255,255,0"
	},
	
}

local userTags = {
	["SaturnXOffical"] = "Dev",
	["Clockmaster55"] = "Test",
}

function tween (obj,info,to)
	local inf = TweenInfo.new(info,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out,0,false,0)
	local t = game:GetService("TweenService"):Create(obj,inf,to)
	t:Play()
	return t
end

function updateList()
	local dist = -20
	local maxsize = 8
	
	for i,v in pairs(ui.Feed:GetChildren()) do 
		if v.Name ~= "Template" and v.Name ~= "ChatDisabled" then
			v.pos.Value +=1
			if v.pos.Value >= maxsize then
				local t = tween(v,.4,{TextTransparency = 1})
				t.Completed:Connect(function()
					v:Destroy()
				end)
			else 
				tween(v,0.4,{Position = UDim2.new(0,6,1,dist*v.pos.Value)})
			end
		end
	end
end

function makeMessage(sender,txt,col)
	local msg = ui.Feed.Template:Clone()
	msg.Parent = ui.Feed
	msg.Visible = false
	msg.Name = sender
	
	local tagdat = {Col = "255,255,255", Txt = ""}
	
	if userTags[sender] ~= nil then
		local tag = chatTags[userTags[sender]]
		
		tagdat.Col = tag.TagRGBTxt
		tagdat.Txt = tag.TagDisplay
	end
	
	local tag = '<font color="rgb('..tagdat.Col..')">'..tagdat.Txt..'</font>'
	local msgstart = '<font face = "SourceSansSemibold">'
	local teamcol = '<font color="rgb('..cols[col]..')>'
	
	msg.Text = '<font face="GothamSemibold">'..tag..'<font color="rgb('..cols[col]..')"> '..sender..'<font face="GothamBold"> :</font></font></font> '..txt
	
	msg.Position = UDim2.new(0,6,1,20)
	
	msg.Visible = true
	
	tween(msg,.45,{Position = UDim2.new(0,6,1,0)})
	--return msg
end

function module.UpdateMessages(sender,text,col)
	ui.Feed.Template.Visible = false
	updateList()
	wait()
	makeMessage(sender,text,col)
end

function module.ChatBan(mins,reason)
	ui.Bar.Box.Text = ''
	ui.ChatBan.Visible = true
	ui.Bar.Visible = false
	ui.ChatBan.Label.Text = 'You have been temporarily blocked from sending chat messages for '..reason
	
	wait(mins*60)
	
	ui.ChatBan.Visible = false
	ui.Bar.Visible = true
end

return module
