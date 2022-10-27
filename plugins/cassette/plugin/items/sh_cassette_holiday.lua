local ITEM = Clockwork.item:New();
ITEM.name = "Holiday Cassette";
ITEM.uniqueID = "holiday_cassette";
ITEM.cost = 50; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "This cassette has several bright symbols of diffrent holidays stickered onto it";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Holiday Archives", { -- Name that the cassette UI will show.
        {
            name = "Tombstone - SSS",
            length = 230, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/j8oe8fmc9lec3kp/Spooky%20Scary%20Skeletons%20%28Remix%29%20-%20Extended%20Mix.mp3?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Micheal Myers Theme Remix",
            length = 222,
            url = "https://dl.dropboxusercontent.com/s/0a7xx585uwhfpn6/HALLOWEEN%20THEME%20%28Trap%20Remix%29%20%28Michael%20Myers%20Theme%29.mp3?dl=0"
        },
        {
            name = "Glee - Jingle Bell Rock",
            length = 152,
            url = "https://dl.dropboxusercontent.com/s/4s1mfjfolkg3ipc/Glee%20-%20Jingle%20Bell%20Rock%20%28Lyrics%29.mp3?dl=0"
        },
        {
            name = "Mariah Carey - All I want for Christmas",
            length = 235,
            url = "https://dl.dropboxusercontent.com/s/e9xe8xafv8qhr7e/Mariah%20Carey%20-%20All%20I%20Want%20For%20Christmas%20Is%20You.mp3?dl=0"
        },
        {
            name = "Europe - The Final Countdown",
            length = 311,
            url = "https://dl.dropboxusercontent.com/s/g5ek1vrighk82x9/The%20Final%20Countdown.mp3?dl=0"
        },
		{
            name = "Ahmed - Jingle Bombs",
            length = 153,
            url = "https://dl.dropboxusercontent.com/s/x7h0uypxq2qs0pa/Jingle%20Bombs%20%28Achmed%29.mp3?dl=0"
        }
 
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();