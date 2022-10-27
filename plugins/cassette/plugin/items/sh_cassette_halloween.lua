local ITEM = Clockwork.item:New();
ITEM.name = "Halloween Cassette";
ITEM.uniqueID = "halloween_cassette";
ITEM.cost = 88; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "An orange and black cassette tape labeled 'Spooky Tunes' with a small ghost scribbled on it.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Halloween Cassette", { -- Name that the cassette UI will show.
        {
            name = "Spooky Scary Skeletons",
            length = 230, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/te7fs61trby4h6o/Spooky%20Scary%20Skeletons%20Remix%20Extended%20Mix?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Rave in the Grave",
            length = 160,
            url = "https://dl.dropboxusercontent.com/s/5wh8t7bv59869bb/AronChupa%2C%20Little%20Sis%20Nora%20-%20Rave%20in%20the%20Grave%20%28Lyrics%20Lyric%20Video%29?dl=0"
        },
        {
            name = "Thriller",
            length = 314,
            url = "https://dl.dropboxusercontent.com/s/r7rgy4au8hoessk/Thriller%20-%20Michael%20Jackson%20%28Lyrics%29?dl=0"
        },
        {
            name = "Ghost Busters",
            length = 240,
            url = "https://dl.dropboxusercontent.com/s/6r4xbqm6ycuomfi/Original%20GhostBusters%20Theme%20Song?dl=0"
        },
        {
            name = "Monster",
            length = 177,
            url = "https://dl.dropboxusercontent.com/s/1knejtl4logihba/Skillet%20-%20Monster%20%28Lyrics%29?dl=0"
        },
        {
            name = "People are Strange",
            length = 133,
            url = "https://dl.dropboxusercontent.com/s/5kto83pvy2zdszw/The%20Doors%20-%20People%20Are%20Strange?dl=0"
        },
        {
            name = "Monster Mash",
            length = 193,
            url = "https://dl.dropboxusercontent.com/s/2ohhhpiqfoj1l4g/Monster%20Mash%20%28Lyrics%29?dl=0"
        },
        {
            name = "Disturbia",
            length = 235,
            url = "https://dl.dropboxusercontent.com/s/kkhsvtu161tvq9q/Disturbia%20-%20Rihanna%20Lyrics?dl=0"
        }
	
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();