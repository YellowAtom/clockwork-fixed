local ITEM = Clockwork.item:New();
ITEM.name = "Vaporwave vol. 1";
ITEM.uniqueID = "vaporwave_cassette";
ITEM.cost = 75;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "Fine and calming tunes, for a relaxed mind.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Vaporwave vol. 1", {
        {
            name = "MACINTOSH PLUS - Lisa Frank 420 a.k.a Modern Computer",
            length = 441,
            url = "https://dl.dropboxusercontent.com/s/8aiahbpjv8xyetd/MACINTOSH%20PLUS%20-%20Lisa%20Frank%20420%20a.k.a%20Modern%20Computer.mp3?dl=0"
        },
        {
            name = "MACINTOSH PLUS - Boot",
            length = 214,
            url = "https://dl.dropboxusercontent.com/s/s0unkij1kex0yqu/Macintosh%20Plus%20-%20Boot.mp3?dl=0"
        },
        {
            name = "Forhill - Expanse",
            length = 245,
            url = "https://dl.dropboxusercontent.com/s/7t6cxssn3ajo02d/Forhill%20-%20Expanse.mp3?dl=0"
        },
        {
            name = "Forhill - Searching",
            length = 297,
            url = "https://dl.dropboxusercontent.com/s/q0t6s7t72agq6m1/Forhill%20-%20Searching.mp3?dl=0"
        },
        {
            name = "Whitewoods - Beach Walk",
            length = 132,
            url = "https://dl.dropboxusercontent.com/s/spn9tlyt20hmqrn/Whitewoods%20-%20Beach%20Walk.mp3?dl=0"
        },
        {
            name = "Whitewoods - Misery Loves",
            length = 117,
            url = "https://dl.dropboxusercontent.com/s/e49si5u0fw4dwaw/Whitewoods%20-%20Misery%20Loves.mp3?dl=0"
        }
 
    })

function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();