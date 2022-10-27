--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();
ITEM.name = "Reggae Cassette";
ITEM.uniqueID = "reggae_cassette";
ITEM.cost = 56;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A casette covered in mud, looks like it'll still work. It has the word 'Reggae' written on it in pink marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Reggae", {
		{
			name = "Barrington Levy - Here I Come",
			length = 230,
			url = "https://dl.dropboxusercontent.com/s/qz51d7aryvc598p/%5BOST%5D%20Saints%20Row%202%20-%20Barrington%20Levy%20-%20Here%20I%20Come%20%28HQ%29.mp3?dl=0"
		},
		{
			name = "Elephant Man - Krazy",
			length = 221,
			url = "https://dl.dropboxusercontent.com/s/47olaa7l712nkta/%5BOST%5D%20Saints%20Row%202%20-%20Elephant%20Man%20-%20Krazy%20%28HQ%29.mp3?dl=0"
		},	
		{
			name = "Eek-a-Mouse - Ganja Smuggling",
			length = 231,
			url = "https://dl.dropboxusercontent.com/s/atsxezv5uqgx4bx/%5BOST%5D%20Saints%20Row%202%20-%20Eek-a-Mouse%20-%20Ganja%20Smuggling%20%28HQ%29.mp3?dl=0"
		},
		{
			name = "Buju Banton - Hey Boy",
			length = 205,
			url = "https://dl.dropboxusercontent.com/s/yeh7ph1a1cb4cxt/%5BOST%5D%20Saints%20Row%202%20-%20Buju%20Banton%20-%20Hey%20Boy%20%28HQ%29.mp3?dl=0"
		},
		{
			name = "I-Octane – Topic Of The Day",
			length = 218,
			url = "https://dl.dropboxusercontent.com/s/g3tnfe9lcok4sar/GTA%20V%20Radio%20%5BBlue%20Ark%5D%20I-Octane%20%E2%80%93%20Topic%20Of%20The%20Day.mp3?dl=0"
		},
		{
			name = "Demarco – Loyals",
			length = 143,
			url = "https://dl.dropboxusercontent.com/s/xoywps1kmmav3mo/GTA%20V%20Radio%20%5BBlue%20Ark%5D%20Demarco%20%E2%80%93%20Loyals.mp3?dl=0"
		},
		{
			name = "Beenie Man - Who Am I",
			length = 197,
			url = "https://dl.dropboxusercontent.com/s/orsrezmfbv57il6/%5BOST%5D%20Saints%20Row%202%20-%20Beenie%20Man%20-%20Who%20Am%20I%20%28HQ%29.mp3?dl=0"
		},
		{
			name = "Mr. Vegas - Heads High",
			length = 213,
			url = "https://dl.dropboxusercontent.com/s/nno0q3dnga1cco6/%5BOST%5D%20Saints%20Row%202%20-%20Mr.%20Vegas%20-%20Heads%20High%20%28HQ%29.mp3?dl=0"
		},
		{
			name = "Dennis Brown - Stop the Fussing and Fighting",
			length = 201,
			url = "https://dl.dropboxusercontent.com/s/l2us0b2560q4kmx/%5BOST%5D%20Saints%20Row%202%20-%20Dennis%20Brown%20-%20Stop%20the%20Fussing%20and%20Fighting%20%28HQ%29.mp3?dl=0"
		},
		{
			name = "Yellowman - Nobody Move, Nobody Get Hurt",
			length = 222,
			url = "https://dl.dropboxusercontent.com/s/91y2019vo5zlxah/GTA%20V%20Radio%20%5BBlue%20Ark%5D%20Yellowman%20-%20Nobody%20Move%2C%20Nobody%20Get%20Hurt.mp3?dl=0"
		},
		{
			name = "Chronixx - Odd Ras",
			length = 179,
			url = "https://dl.dropboxusercontent.com/s/027ryqpcmzels80/GTA%20V%20Radio%20%5BBlue%20Ark%5D%20Chronixx%20-%20Odd%20Ras.mp3?dl=0"
		},
		{
			name = "Vybz Kartel – Addi Truth",
			length = 184,
			url = "https://dl.dropboxusercontent.com/s/ek03pwxnrne8gej/GTA%20V%20Radio%20%5BBlue%20Ark%5D%20Vybz%20Kartel%20%E2%80%93%20Addi%20Truth.mp3?dl=0"
		}	
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();