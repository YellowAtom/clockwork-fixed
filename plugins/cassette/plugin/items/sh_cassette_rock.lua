--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Rock Cassette";
ITEM.uniqueID = "rock_cassette";
ITEM.cost = 62;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A darker looking cassette with the word 'Rock' written on it in quite bad handwriting.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Rock", {
		{
			name = "Ashes Remain - On My Own",
			length = 175,
			url = "https://dl.dropboxusercontent.com/s/28gbubi0y6d6vfr/Ashes%20Remain%20-%20On%20My%20Own%20%28Pseudo%20Video%29.mp3?dl=0"
		},
		{
			name = "Breaking Benjamin - Evil Angel",
			length = 221,
			url = "https://dl.dropboxusercontent.com/s/gtx21hwnqrje5uy/Breaking%20Benjamin-%20Evil%20Angel%20%28with%20lyrics%29.mp3?dl=0"
		},
		{
			name = "Breaking Benjamin - Until the End",
			length = 270,
			url = "https://dl.dropboxusercontent.com/s/fxjp7fqjl4wya5v/Breaking%20Benjamin%20-%20Until%20the%20End%20Lyrics.mp3?dl=0"
		},
		{
			name = "Skillet -  Never Surrender",
			length = 208,
			url = "https://dl.dropboxusercontent.com/s/yyr9tahc2d3lrh0/Skillet%20-%20%20Never%20Surrender%20Lyrics.mp3?dl=0"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();