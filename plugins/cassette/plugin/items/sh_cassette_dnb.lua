local ITEM = Clockwork.item:New();
ITEM.name = "DnB Tape";
ITEM.uniqueID = "dnb_tape";
ITEM.cost = 58; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "v"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes. (The UU denied my tape :( )
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A dusty, red tape labelled 'Drum and Bass'.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("DnB Tape", { -- Name that the cassette UI will show.
        {
            name = "Hold Your Colour",
            length = 451, -- Length of song in seconds.
            url = "https://d.dropboxusercontent.com/s/tjbha9qmg34gg7x/pendulum%20hold%20your%20colour-qtD1IpH5a5Q.mp3?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "Still Grey",
            length = 465,
            url = "https://dl.dropboxusercontent.com/s/kn8h461x4qmkmnv/Pendulum%20-%20Still%20Grey.mp3?dl=0"
        },
        {
            name = "Nervenkitzel",
            length = 171,
            url = "https://dl.dropboxusercontent.com/s/te12ye7azi12brk/PHACE%20%26%20MEFJUS%20-%20NERVENKITZEL%20%5BLINKED%2001%5D-5uA2otwnFeI.mp3?dl=0"
        },
        {
            name = "Immunize",
            length = 276,
            url = "https://dl.dropboxusercontent.com/s/06n95l1dhxa8kc6/Pendulum%20-%20Immunize%20%5BHD%20-%20320kbps%5D-t_kM1yEcDxA.mp3?dl=0"
        },
        {
            name = "Blitz",
            length = 257,
            url = "https://dl.dropboxusercontent.com/s/u7kruk7hmpd7t5v/Mefjus%20-%20Blitz-rYnhrIDMXRU.mp3?dl=0"
        },
        {
            name = "Slam",
            length = 341,
            url = "https://dl.dropboxusercontent.com/s/b8j587lfw6trgnh/Pendulum%20-%20Slam%20%5BHD%20-%20320kbps%5D-Q89OdbX7A8E.mp3?dl=0"
        }
 
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();