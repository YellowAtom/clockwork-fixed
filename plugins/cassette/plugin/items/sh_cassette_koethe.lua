local ITEM = Clockwork.item:New();
ITEM.name = "Koethe Cassette";
ITEM.uniqueID = "cassette_koethe";
ITEM.cost = 40; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A slightly broken casette. On the front is a drawing of a man holding a guitar, and 'Koethe' in a handwriting font. On the back, the songs are listed.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Koethe", { -- Name that the cassette UI will show.
        {
            name = "Price",
            length = 253, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/e4tuv78lr199oie/videoplayback%20%281%29.mp4?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Memory",
            length = 273,
            url = "https://dl.dropboxusercontent.com/s/9yj822fg291lrgt/videoplayback%20%282%29.mp4?dl=0"
        },
        {
            name = "Amber",
            length = 300,
            url = "https://dl.dropboxusercontent.com/s/hsf99sk1rm7m75n/videoplayback%20%283%29.mp4?dl=0"
        },
        {
            name = "Take it all back",
            length = 205,
            url = "https://dl.dropboxusercontent.com/s/1mkoza5y2rmxce3/videoplayback%20%284%29.mp4?dl=0"
        },
        {
            name = "Storm",
            length = 205,
            url = "https://dl.dropboxusercontent.com/s/yrw497l8o0s6j2h/videoplayback%20%285%29.mp4?dl=0"
        }

    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;

ITEM:Register();