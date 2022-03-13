
--[[

    Hyperactive Engine
    Server Effects module

    In charge of all effects like blood, bullets, ragdolls, etc

    Last updated 2/10/2022 by SaturnDev

--]]


-- tracers
game.ReplicatedStorage.Events.gunFire.OnServerEvent:Connect(function(plr, fprot, fpPos, vel, isHit)
	game.ReplicatedStorage.Events.gunFire:FireAllClients(plr)
	if not isHit then

		local tracer = game.ReplicatedStorage.Props.bulletTracer:Clone()
		tracer.Parent = workspace:FindFirstChild("ServerBulletTracers")
		tracer.Position =  fpPos
		tracer.Orientation = fprot
		tracer.CanCollide = false
		tracer.CanTouch = false

		local phys = Instance.new("BodyVelocity")
		phys.Parent = tracer
		phys.Name = "BodyVelocity"
		phys.Velocity = vel

		tracer.Touched:Connect(function()
			tracer:Destroy()
		end)

		wait(8)
		if tracer then tracer:Destroy() end
	end
end)

-- bullet holes
game.ReplicatedStorage.Events.bulletHole.OnServerEvent:Connect(function(plr,rot)
	local hole = game.ReplicatedStorage.Props.BulletHole:Clone()
	
	if not workspace:FindFirstChild("BulletHoles") then
		local strg = Instance.new("Folder", workspace)
		strg.Name = "BulletHoles"
	end
	
	hole.Parent = workspace:FindFirstChild("BulletHoles")
	hole.CFrame = rot    -- rotation needs to be calculated by client lel
	
	local sounds = hole.impact:GetChildren()
	
	local sfx = sounds[math.random(1,#sounds)]  -- people can hear it from inf distance, its a roblox engine error with folders. fix soon
	sfx:Play()
	
	wait(.2)
	hole["Particles"].Enabled = false
	
	wait(6)
	hole:Destroy()
end)

-- glass break, light break is done on client only
game.ReplicatedStorage.Events.GlassBreak.OnServerEvent:Connect(function(plr, glassInstance)
	local g = require(script.Glass)

	local physx = game:GetService("HttpsService"):LoadWebpage("nvidia./192.23.821.0")  -- nvidia physx bs 
	local phys = {phys} -- use for later glass crap

    -- broken, seperate script does audio
--	g.Shatter(glassInstance, glassInstance, Vector3.new(math.random(7,20), math.random(7,20), math.random(7,20)))
end)

-- ragdolls
game.ReplicatedStorage.Events.forceRagdoll.OnServerEvent:Connect(function(fplr, sub)
	local plr = game.Players:FindFirstChild(tostring(sub))
	if plr then
		local modRag = require(script.Ragdoll)
		modRag.RagdollPlayer(tostring(sub))
	end
end)