local ITEM = Clockwork.item:New();
ITEM.name = "Tally Hall Vol. 1";
ITEM.uniqueID = "tallyhalltape";
ITEM.cost = 61;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A stained, white cassette with the words 'Tally Hall Vol. 1' written on it in pencil.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Tally Hall Vol. 1", {
        {
            name = "Hymn for a Scarecrow",
            length = 290, -- Length of song in seconds.
            url = "https://www.dl.dropboxusercontent.com/s/urntinnuw3ob6ma/Hymn%20for%20a%20Scarecrow%20%28128%20kbps%29.mp3?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Misery Fell",
            length = 214,
            url = "https://www.dl.dropboxusercontent.com/s/suh79gqkz70i78w/Misery%20Fell%20%28128%20kbps%29.mp3?dl=0"
        },
        {
            name = "Turn the Lights Off",
            length = 176,
            url = "https://www.dl.dropboxusercontent.com/s/rlgn310t6ocbumq/Turn%20the%20Lights%20Off%20%28128%20kbps%29.mp3?dl=0"
        },
        {
            name = "&",
            length = 194,
            url = "https://www.dl.dropboxusercontent.com/s/e2ji3fihje6w9ge/%26%20%28128%20kbps%29.mp3?dl=0"
        },
        {
            name = "Ruler of Everything",
            length = 223,
            url = "https://www.dl.dropboxusercontent.com/s/s88vpstnmcn8eml/Tally%20Hall%20-%20Ruler%20of%20Everything%20%28128%20kbps%29.mp3?dl=0"
        },
		{
			name = "Banana Man",
			length = 270,
			url = "https://www.dl.dropboxusercontent.com/s/v3i1b65bzgdr0n0/Tally%20Hall%20-%20Banana%20Man%20%28128%20kbps%29.mp3?dl=0"
		}
    })

-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();