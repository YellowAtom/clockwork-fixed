local ITEM = Clockwork.item:New();
ITEM.name = "Dare Cassette";
ITEM.uniqueID = "dare_cassette";
ITEM.cost = 42;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A cassette covered in neon red, with a daring blackspace. The cover depicts an aggressive helmeted motorcyclist.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Dare Album", {
        {
            name = "Stieglitz - Escape",
            length = 153,
            url = "https://dl.dropboxusercontent.com/s/obwi3tufu8da5qq/Stieglitz%20-%20Escape.mp3?dl=0"
        },
        {
            name = "Radiohunter - Stalk With Me",
            length = 247,
            url = "https://dl.dropboxusercontent.com/s/epswcf9vepl93eo/Radiohunter%20-%20Stalk%20With%20Me.mp3?dl=0"
        },
        {
            name = "Lazerhawk - Overdrive",
            length = 274,
            url = "https://dl.dropboxusercontent.com/s/https://www.dropbox.com/s/e2j02mnl9ky24hl/Lazerhawk%20-%20Overdrive.mp3?dl=0"
        },
        {
            name = "Kavinsky - Nightcall",
            length = 260,
            url = "https://dl.dropboxusercontent.com/s/io46hb1bvtt2022/Kavinsky%20-%20Nightcall%20%28Drive%20Music%20Video%29.mp3?dl=0"
        },
        {
            name = "Hyper - Spoiler",
            length = 272,
            url = "https://dl.dropboxusercontent.com/s/bo3wtza6r9vjrmd/Hyper%20-%20Spoiler.mp3?dl=0"
        }

    })

function ITEM:OnDrop(player, position)
end;

ITEM:Register();