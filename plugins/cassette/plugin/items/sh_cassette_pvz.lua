--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Plant Cassette";
ITEM.uniqueID = "pvz_cassette";
ITEM.cost = 38;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A green tinted cassette with the word 'PvZ' written on it with a marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Plant", {
		{
			name = "Main Menu",
			length = 87,
			url = "https://files.catbox.moe/xvi31m.mp3"
		},
		{
			name = "Day",
			length = 139,
			url = "https://files.catbox.moe/qstlvc.mp3"
		},
		{
			name = "Night",
			length = 144,
			url = "https://files.catbox.moe/1ixtld.mp3"
		},
		{
			name = "Pool",
			length = 101,
			url = "https://files.catbox.moe/jo4og8.mp3"
		},
		{
			name = "Fog",
			length = 222,
			url = "https://files.catbox.moe/j4uy0v.mp3"
		},
		{
			name = "Roof",
			length = 108,
			url = "https://files.catbox.moe/qu0bo5.mp3"
		},
		{
			name = "Mini-Games",
			length = 106,
			url = "https://files.catbox.moe/quc17w.mp3"
		},
		{
			name = "Ultimate Battle",
			length = 115,
			url = "https://files.catbox.moe/kcl0nv.mp3"
		},
		{
			name = "Zomboss Battle",
			length = 100,
			url = "https://files.catbox.moe/sm9lzn.mp3"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();