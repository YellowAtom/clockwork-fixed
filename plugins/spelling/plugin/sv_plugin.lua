--[[
	This script has been purchased for "Blt950's HL2RP & Clockwork plugins" from CoderHire.com
	© 2014 Blt950 do not share, re-distribute or modify
	without permission.
--]]

local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

function PLUGIN:ChatBoxAdjustInfo(info)
	if (info.class == "ic" or info.class == "yell" or info.class == "radio" or info.class == "whisper" or info.class == "request") then
		for k, v in pairs(Schema.voices.stored.normalVoices) do
			if (string.lower(info.text) == string.lower(v.command)) then
				return;
			end;
		end;

		// Add capital
		local editCapital = string.sub(info.text, 1, 1);
		info.text = (string.upper(editCapital)..string.sub(info.text, 2, string.len(info.text)));
		
		// Add period
		local endText = string.sub(info.text, -1);

		if ( (endText != ".") and (endText != "!") and (endText != "?" ) ) then
			info.text = (info.text..".");
		end;
	end
end;