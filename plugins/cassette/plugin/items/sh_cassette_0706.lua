local ITEM = Clockwork.item:New();
ITEM.name = "0706: Beautiful Night";
ITEM.uniqueID = "beautiful_night";
ITEM.cost = 42;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A clean looking cassette with the following written on it with pink marker - 'Some nice, smooth jazz for everyone to enjoy!'";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Beautiful Night", {
        {
            name = "Summer Night",
            length = 266,
            url = "https://dl.dropboxusercontent.com/s/ivfwk68wtlwonqr/Brian%20Tarquin%20-%20Summer%20Nights.mp3?dl=0"
        },
        {
            name = "Penthouse View",
            length = 314,
            url = "https://dl.dropboxusercontent.com/s/e811r9y3bwjpb6s/Gregg%20Karukas%20-%20Penthouse%20View.mp3?dl=0"
        },
        {
            name = "Love Like This",
            length = 270,
            url = "https://dl.dropboxusercontent.com/s/4g2l6bzu4mbd4df/Kim%20Waters%20-%20Love%20like%20this.mp3?dl=0"
        },
        {
            name = "Heaven",
            length = 345,
            url = "https://dl.dropboxusercontent.com/s/gdjesawix17vc8l/Ronny%20Jordan%20-%20Heaven.mp3?dl=0"
        },
 
    })

function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();