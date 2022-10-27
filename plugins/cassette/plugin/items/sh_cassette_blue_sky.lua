local ITEM = Clockwork.item:New();
ITEM.name = "Blue Sky";
ITEM.uniqueID = "bluesky_cassette";
ITEM.cost = 48; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A flashy looking cassette, one side of the cassette being bright blue and on the other side, there seems to be a pattern of re-occurring chemical structures. On the back of the cassette, there seems to be a sticker with something written on it, 'Music to cook to'.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Blue Sky", { -- Name that the cassette UI will show.
        {
            name = "Tommy & Shondells - Crystal Blue Persuasion",
            length = 237, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/cae5u1tgh12n4ic/Breaking%20Bad%20Season%205%20-%20Crystal%20Blue%20Persuasion.mp3?dl=0" -- https://dl.dropboxusercontent.com
        },
        {
            name = "Chuy Flores - Veneno",
            length = 164,
            url = "https://dl.dropboxusercontent.com/s/3mfuyhwajmqn6p5/Chuy%20Flores%20-%20Veneno.mp3?dl=0"
        },
        {
            name = "The Peddlers - On A Clear Day",
            length = 219,
            url = "https://dl.dropboxusercontent.com/s/3pi3j1aynjsnr0c/The%20Peddlers-%20On%20A%20Clear%20Day%20You%20Can%20See%20Forever.mp3?dl=0"
        },
        {
            name = "Fujiya & Miyagi - Uh!",
            length = 179,
            url = "https://dl.dropboxusercontent.com/s/m3ai90izan3d9tp/Fujiya%20%26%20Miyagi%20-%20Uh%21.mp3?dl=0"
        },
        {
            name = "Badfinger - Baby Blue",
            length = 217,
            url = "https://dl.dropboxusercontent.com/s/olcp5fx8hsrh0yc/Badfinger%20-%20Baby%20Blue.mp3?dl=0"
        }
 
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();