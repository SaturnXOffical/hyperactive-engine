

local ev = game.ReplicatedStorage.Events.Misc.updateChat
local banev = game.ReplicatedStorage.Events.Misc.chatBan
local quotes = require(game.ReplicatedStorage.Modules.ServerTips)

ev.OnServerEvent:Connect(function(p,s,t,c)
	
	local f = "[Server failed to filter message, error: final msg unset]"
	local ban = false
	
	for i,v in pairs(game.Players:GetPlayers()) do 
		f = game:GetService('Chat'):FilterStringAsync(t,p,p)
		if f == '' or f == ' ' or ban == true then
			f = "[Filtered by server]"
			ban = true
		end
		ev:FireClient(v,s,f,c)
	end
	
	if ban == true then
		banev:FireClient(p,"getting a message filtered [swearing]")
	end
end)

game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		ev:FireAllClients('Console',p.Name.." has joined the game",'Console')
	end)
end)

game.Players.PlayerRemoving:Connect(function(p)
	ev:FireAllClients('Console',p.Name.." has left the game",'Console')
end)

while true do
	wait(200)
	local q = quotes[math.random(1,#quotes)]
	ev:FireAllClients("Console",tostring(q),"Console")
end