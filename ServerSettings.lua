
--[[

    Hyperactive Engine
    Server Settings module

    The server settings module (accessable by :GetSettings()) is a ModuleScript containing values for server-wide settings.
    This does not contain mid-round values.

    This script has zero code within, and only contains settings for the actual scripts to access.

--]]

local serverSettings = {
	
	mapsToLoad = {
		doVoting = true,
		doVotingInStudio = false,  -- do voting in the editor? no lol
		
		vipServer = {
			name = "Crane",
			mode = "King of the Hill"
		},
		
		studioEditor = {
			name = "Ruins",
			mode = "Point Domination"
		},
		
		standardServer = {
			name = "Ravod",
			mode = "King of the Hill"
		},
		
		reservedServer = {
			-- bots map
			name = "Rig",
			mode = "Team Deathmatch"
		}
	},
	
	botsConfig = {
		loadBots = true,
		whitelistPlayers = false,
		
		botsFalcons = 4,
		botsMavericks = 4,
		
		botsDifficulty = "easy",
		
		botsDefaultGun = {
			gun = "M4A1",
			category = "Assault"
		},
		
		majorityUsesRecommended = true,
		obeyCountdownFreezes = true,
		
		dedicateCpu = "client", -- what cpu does the pathfinding & animating  
        -- server allows for faster performance but lower framrates and sometimes high ping
        -- but client allows for faster ping and bot framerates, and small lag spikes when bots load
		
		multiplayerWithBots = false
		
	},
	
	defaultMenuScenes = {
		studio = "Dev",
		player = "Office"
	},
	
	defaultBullets = {
		-- coming soon
	},
	
	--[[

            Tags are now located inside the Chat script, though I wish it uses a system like this one

	chatTags = {
		roles = {
			[0] = {TagText = "TESTER", TagColor = Color3.new(1, 0.941176, 0.270588)},
			[1] = {TagText = "SUPPORTER", TagColor = Color3.new(0.223529, 0.701961, 1)},
			[2] = {TagText = "OG", TagColor = Color3.new(0.305882, 1, 0.258824)},
			[3] = {TagText = "DEVELOPER", TagColor = Color3.new(0.792157, 0.14902, 0.14902)}
		},
		
		members = {
			["SaturnXOffical"] = 3,
			["BlueDustTheCat"] = 3,
			["konzumed"] = 3,
			
			["crabfg"] = 0,
			["nikkalotz"] = 0,
		}
	}
	--]]
}

return serverSettings