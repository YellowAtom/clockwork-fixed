local PLUGIN = PLUGIN

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("legshotamount", 0)
	playerVars:Number("armshotamount", 0)
end