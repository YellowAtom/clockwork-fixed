local ITEM = Clockwork.item:New();
ITEM.name = "Bar Blues Cassette";
ITEM.uniqueID = "bar_blues_cassette";
ITEM.cost = 67;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A small cassette with meticulous handwriting that says 'Best of blues' ";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Bar Blues", {
        {
            name = "Lucille - BB King",
            length = 615,
            url = "https://dl.dropboxusercontent.com/s/9tbey2wvzvsj51o/B.B.%20King%20-%20Lucille.mp3?dl=0"
        },
        {
            name = "Goodbye Pork Pie Hat - Charles Mingus",
            length = 570,
            url = "https://dl.dropboxusercontent.com/s/fyz6j9tlfunx7z8/Charles%20Mingus%20-%20Goodbye%20Pork%20Pie%20Hat.mp3?dl=0"
        },
        {
            name = "The Sky is Crying - Gary B.B. Coleman",
            length = 550,
            url = "https://dl.dropboxusercontent.com/s/8jr5og60nxu006o/Gary%20B.B.%20Coleman%20-%20The%20Sky%20is%20Crying.mp3?dl=0"
        },
        {
            name = "When the Hurt is Over - Mighty Sam McClain",
            length = 485,
            url = "https://dl.dropboxusercontent.com/s/ruueda6coty71g5/Mighty%20Sam%20McClain%20-%20When%20The%20Hurt%20Is%20Over.mp3?dl=0"
        },
        {
            name = "Self-Portrait in Three Colors - Charles Mingus",
            length = 190,
            url = "https://dl.dropboxusercontent.com/s/76p0s8st4vzya78/Self-Portrait%20in%20Three%20Colors.mp3?dl=0"
        }
 
    })

function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();