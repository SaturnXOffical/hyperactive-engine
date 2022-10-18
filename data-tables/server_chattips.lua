
local tips = {
	'Pressing F allows you to switch angles when aiming your gun.',
	'Pressing E when an enemy or multiple enemies are inside your crosshair allows you to tag them as long as they remain onscreen.',
	'There is a 1 in 10,000 chance that a ragdoll will spawn as Steve from Minecraft (100% chance in alpha)',
	'Headshot bonuses get rewarded if the final shot that kills them is a headshot',
	'There are '..#require(script.Parent.MatchQuotes)..' quotes in game.',
	'There are '..#game.ServerStorage.Maps:GetChildren()..' maps in game.',
	'There are '..#game.ReplicatedStorage.Attachments.Models:GetChildren()..' attachment models in game',
}

return tips
