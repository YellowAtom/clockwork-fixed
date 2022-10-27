local ITEM = Clockwork.item:New();
ITEM.name = "Hardrock Cassette";
ITEM.uniqueID = "Hardrock Cassette";
ITEM.cost = 17; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = false; -- Buyable from the business menu or not.
ITEM.description = "Rather a clean cassette, appearing duplicated once or twice, having a paper piece sticked on it with text written: Hardrock Cassette";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Hardrock Cassette", { -- Name that the cassette UI will show.
        {
            name = "Criminal - New Disorder",
            length = 225, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/w1ngmh80t5u32fk/Criminal%20-%20New%20Disorder.mp3?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Helmet - Repetition",
            length = 185,
            url = "https://dl.dropboxusercontent.com/s/rrcsqpi3weqlkp5/Helmet%20-%20Repetition.mp3?dl=0" 
        }, 
        {
            name = "Judas Priest - Painkiller",
            length = 375,
            url = "https://dl.dropboxusercontent.com/s/s71o78bh1t53o6n/Judas%20Priest%20-%20Painkiller.mp3?dl=0"
        },
        {
            name = "Keel - Speed Demon",
            length = 225,
            url = "https://dl.dropboxusercontent.com/s/7lbxrsrgdh7zxlr/Keel%20-%20Speed%20Demon%20%281%29.mp3?dl=0"
        },
        {
            name = "Disturbed - Ten Thousand Fists",
            length = 225,
            url = "https://dl.dropboxusercontent.com/s/2fecmmgk3yf1b69/Disturbed%20-%20Ten%20Thousand%20Fists.mp3?dl=0"
        }

    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;

ITEM:Register();