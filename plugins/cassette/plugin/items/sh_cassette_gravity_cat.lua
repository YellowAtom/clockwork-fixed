local ITEM = Clockwork.item:New();
ITEM.name = "Future Cassette";
ITEM.uniqueID = "future_cassette";
ITEM.cost = 40;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A clean looking cassette with a well-drawn picture of a purple cat on it.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Future", {
		{
			name = "Aimless Wander",
			length = 167,
			url = "https://dl.dropboxusercontent.com/s/62r300w1iv2dh22/Aimless%20Wander.mp3?dl=0"
		},
		{
			name = "Higly Strung",
			length = 53,
			url = "https://dl.dropboxusercontent.com/s/eyq5ve5ladrrgjc/And%20It%20Hummed.mp3?dl=0"
		},
		{
			name = "Battle For What Is Wrong",
			length = 61,
			url = "https://dl.dropboxusercontent.com/s/res0pbuskpdykgb/Battle%20For%20What%20Is%20Wrong.mp3?dl=0"
		},
		{
			name = "Showdown",
			length = 167,
			url = "https://dl.dropboxusercontent.com/s/1rti2nskokbhsto/Battle%20For%20Line%2086.mp3?dl=0"
		},
		{
			name = "Down In The Caves",
			length = 23,
			url = "https://dl.dropboxusercontent.com/s/0ktf8gf97h5tc4u/The%20Lamp%20Shone.mp3?dl=0"
		},
		{
			name = "The Garden Of Elath",
			length = 81,
			url = "https://dl.dropboxusercontent.com/s/jgyls498r6v3qqg/The%20Garden%20Of%20Elath.mp3?dl=0"	
		},
		{
			name = "Sensory Deprovation",
			length = 70,
			url = "https://dl.dropboxusercontent.com/s/exedo3jw9yact2x/Sensory%20Deprovation%20And%20Cheese.mp3?dl=0"
		},
		{
			name = "Unkempt Tomb",
			length = 104,
			url = "https://dl.dropboxusercontent.com/s/y2pmb93etcmw8m4/Unkempt%20Tomb.mp3?dl=0"
		}
	})

function ITEM:OnDrop(player, position)
end;

ITEM:Register();