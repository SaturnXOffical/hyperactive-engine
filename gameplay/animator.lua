local module = {}

function module.bobble_walk(dt,input)
	

	
		local t = tick()
		local bobbleX = .03*math.sin(tick()*9)
		local bobbleY = .04*math.sin(tick()*5)

		local intensity = 1.4

		if input.Aim == true then intensity = 0.5 end

		-- SPRINT
		--	bobbleX = .16*math.sin(tick()*8.6)
		--	bobbleY = .06*math.sin(tick()*14.4)

				--[[
				if walkInput == 'a' then
					renderGuns.Primary.vm_alignment.CFrame = CFrame.new(renderGuns.Primary.vm_alignment.CFrame.Position.X,renderGuns.Primary.vm_alignment.CFrame.Position.Y,swayTiltProperties.Max)
				elseif walkInput == 'd' then
					renderGuns.Primary.vm_alignment.CFrame = CFrame.new(renderGuns.Primary.vm_alignment.CFrame.Position.X,renderGuns.Primary.vm_alignment.CFrame.Position.Y,-swayTiltProperties.Max)
				else 
					renderGuns.Primary.vm_alignment.CFrame = CFrame.new(renderGuns.Primary.vm_alignment.CFrame.Position.X,renderGuns.Primary.vm_alignment.CFrame.Position.Y,0)
				end
				--]]
		return CFrame.Angles(bobbleX*intensity,bobbleY*intensity,0)
end

function module.bobble_idle ()
	
		local t = tick()
		local bobbleX = .12*math.sin(tick()*.3)
		local bobbleY = .05*math.sin(tick()*1)

		local intensity = 1.1

		--if input.Aim == true then intensity = 1.1 end

		-- SPRINT
		--	bobbleX = .16*math.sin(tick()*8.6)
		--	bobbleY = .06*math.sin(tick()*14.4)

				--[[eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
				if walkInput == 'a' then
					renderGuns.Primary.vm_alignment.CFrame = CFrame.new(renderGuns.Primary.vm_alignment.CFrame.Position.X,renderGuns.Primary.vm_alignment.CFrame.Position.Y,swayTiltProperties.Max)
				elseif walkInput == 'd' then
					renderGuns.Primary.vm_alignment.CFrame = CFrame.new(renderGuns.Primary.vm_alignment.CFrame.Position.X,renderGuns.Primary.vm_alignment.CFrame.Position.Y,-swayTiltProperties.Max)
				else 
					renderGuns.Primary.vm_alignment.CFrame = CFrame.new(renderGuns.Primary.vm_alignment.CFrame.Position.X,renderGuns.Primary.vm_alignment.CFrame.Position.Y,0)
				end
				--]]
		return CFrame.new(bobbleX*intensity,bobbleY*intensity,0)
end

function module.look_sway(x,y,clamp,anim)
	
	local function lerp (a,b,t)
		return a+(b-a)*t
	end
	
	local final = CFrame.Angles(x,y,0)*CFrame.Angles(-0.2, -0.19, -0.012)

	local xc,yc,zc = final:ToOrientation()

	local clampy = math.clamp(math.deg(yc),-clamp.Y,clamp.Y)
	clampy = math.rad(clampy)
	
	local clampx = math.clamp(math.deg(xc),-clamp.X,clamp.X)	
	clampx = math.rad(clampx)

	final = CFrame.Angles(-clampx,-clampy,0)

	return anim.RotSway:Lerp(final,.2)
end

return module
