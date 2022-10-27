local ITEM = Clockwork.item:New();
ITEM.name = "Tape Deck Cleaner";
ITEM.uniqueID = "cassette_cleaner";
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.category = "Music";
ITEM.business = false;
ITEM.description = "A bright red cassette with a magnet and a brush instead of an audio track.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("INVALID TRACK", {
        {
            name = "NO DATA AVAILABLE",
            length = 45,
            url = "https://dl.dropboxusercontent.com/s/trfxfxlvkwlj59p/clean.mp3"
        }
    })

function ITEM:OnDrop(player, position)
end;

ITEM:Register();