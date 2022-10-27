local ITEM = Clockwork.item:New();
ITEM.name = "Immortal Cassette";
ITEM.uniqueID = "technique_cassette";
ITEM.cost = 100; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A Cassette from Harlem New York bearing songs of hope.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Best of Immortal Technique", { -- Name that the cassette UI will show.
        {
            name = "Point of No Return",
            length = 240, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/luvaxapacb5jbvt/02%20-%20The%20Point%20of%20No%20Return.mp3?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Peruvian Cocaine",
            length = 288,
            url = "https://dl.dropboxusercontent.com/s/x1xwodc9xwpbbe7/03%20-%20Peruvian%20Cocaine.mp3?dl=0"
        },
        {
            name = "Harlem Streets",
            length = 232,
            url = "https://dl.dropboxusercontent.com/s/2zt27ze2rkhxcle/04%20-%20Harlem%20Streets.mp3?dl=0"
        },
        {
            name = "Industrial Revolution",
            length = 218,
            url = "https://dl.dropboxusercontent.com/s/caglgz5tpzhh6qd/07%20-%20Industrial%20Revolution.mp3?dl=0"
        },
		{
            name = "Internally Bleeding",
            length = 165,
            url = "https://dl.dropboxusercontent.com/s/44wywoyv0mkc6u5/11%20-%20Internally%20Bleeding.mp3?dl=0"
        },
        {
            name = "Leaving the Past",
            length = 000,
            url = "https://dl.dropboxusercontent.com/s/uua2vsf6o1kqkes/15%20-%20Leaving%20The%20Past.mp3?dl=0"
        },
		{
            name = "Natural Beauty",
            length = 224,
            url = "https://dl.dropboxusercontent.com/s/kk5zyinz5uynhht/Immortal%20Technique%20-%20Natural%20Beauty.mp3?dl=0"
        }

    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;

ITEM:Register();