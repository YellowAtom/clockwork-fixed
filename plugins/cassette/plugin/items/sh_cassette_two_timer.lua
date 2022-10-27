local ITEM = Clockwork.item:New();
ITEM.name = "Two Timer By Fredrick Brown";
ITEM.uniqueID = "two_timer";
ITEM.cost = 32;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A dark grey cassette with a pale, bald male drawn crudely on it.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Two Timer By Fredrick Brown", { -- Name that the cassette UI will show.
        {
            name = "Two Timer",
            length = 329, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/kmx8ypq6mnrgpv7/Fredrick%20Brown%20%20%20Two%20Timer%20%20%20%20Science%20Fiction%20Novel.wav?dl=0"
		}
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;

ITEM:Register();