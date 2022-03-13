
-- Quotes that get sent by the server/console in Chat

local quotes = {
	"Press spacebar to deploy on the map.",
	"Shoot the enemy to kill them",
	"Your teamates are here to assist you in battle.",
	"Go for the capture points, you'll get home faster",
	"You can change your UI color theme and menu environment in the settings menu.",
	--"TIP: Press Shift + L to enter cinematic mode",
	"Hitting headshots grant you additional XP upon kill.",
	--"TIP: Press E to spot enemy players that are in view",
	"Need a random number? Here's one: "..tostring(math.random(1,999999)),
	"Not entirely sure, but I think 2+2 equals the flavor of seeing the scent of a car battery",
	"Yes",
	"MAYONAISE ON AN ESCELATOR",
	"Above is secretley a YouTuber",
	"Check out the Settings menu to grant yourself some potentially assisting features.",
	"Hitting a crossmap (280+ studs) with a BFG 50 is standard. How tf..?",
	"Furries are kewl",
	

	
}

return quotes		-- chat engine fetches it so this just gives it back to the server

--[[
	
	How it fetches is by this

	local message = quotes[math.random(1,#quotes)]

	Easy lol

]]
