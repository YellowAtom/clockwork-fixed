local ITEM = Clockwork.item:New();
ITEM.name = "Int Rec 1 Cassette";
ITEM.uniqueID = "intrec1_cassette";
ITEM.cost = 85;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A Black Cassette Tape bearing what appears to be 'Int. Rec. 1' Scribled in white marker.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Int Rec 1", {
        {
            name = "Alex Turner - Stuck on the Puzzle",
            length = 210,
            url = "https://dl.dropboxusercontent.com/s/l7xtz1jbes3gi86/Alex%20Turner%20-%20Stuck%20on%20the%20Puzzle.mp3?dl=0"
        },
        {
            name = "Lumé - Young Man",
            length = 166,
            url = "https://dl.dropboxusercontent.com/s/9qym3npdex5tszv/Lum%C3%A9%20-%20Young%20Man%20%28Official%20Music%20Video%29.mp3?dl=0"
        },
        {
            name = "Stuck in the Sound - Silent and Sweet",
            length = 288,
            url = "https://dl.dropboxusercontent.com/s/lr1jgmq8oqqkl2f/Stuck%20in%20the%20Sound%20-%20Silent%20and%20Sweet%20%5BOfficial%20Video%5D.mp3?dl=0"
        },
        {
            name = "Yung Gravy - 1 Thot 2 Thot Red Thot Blue Thot",
            length = 131,
            url = "https://dl.dropboxusercontent.com/s/itmv4ciiukurovg/Yung%20Gravy%20-%201%20Thot%202%20Thot%20Red%20Thot%20Blue%20Thot%20%5Bprod.%20Dollie%5D.mp3?dl=0"
        },
        {
            name = "Delta Heavy - Ghost",
            length = 255,
            url = "https://dl.dropboxusercontent.com/s/ya1lkdo07n4kgu1/Delta%20Heavy%20-%20Ghost.mp3?dl=0"
        },
        {
            name = "Tristam - Till It's Over",
            length = 270,
            url = "https://dl.dropboxusercontent.com/s/hqw7kysbjdbq5k3/%5BGlitch%20Hop%20or%20110BPM%5D%20-%20Tristam%20-%20Till%20It%27s%20Over%20%5BMonstercat%20Release%5D.mp3?dl=00"
        },
        {
             name = "Tristam & Braken - Frame of Mind",
            length = 270	,
            url = "https://dl.dropboxusercontent.com/s/8h0rxg5qsscfhgk/%5BDnB%5D%20-%20Tristam%20%26amp%3B%20Braken%20-%20Frame%20of%20Mind%20%5BMonstercat%20Release%5D.mp3?dl=0"
        },
        {
             name = "Johnny Cash - Rusty Cage",
            length = 174,
            url = "https://dl.dropboxusercontent.com/s/kkmqr71pfpyuh3r/Johnny%20Cash%20-%20Rusty%20Cage%20Mob%20Of%20The%20Dead%20Theme%20Song.mp3?dl=0"
        },
        {
             name = "Beauty of Annihilation",
            length = 273,
            url = "https://dl.dropboxusercontent.com/s/x2r5nk1y5uvk0lk/Beauty%20of%20Annihilation%20-%20Elena%20Siegman%20-%20Lyrics%20%5BOfficial%5D.mp3?dl=0"
        },
        {
             name = "Fascinating Child",
            length = 233,
            url = "https://dl.dropboxusercontent.com/s/03p2er33wkbtxoi/14%20Fascinating%20Child.mp3?dl=0"
        }
 
    })
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();