local ITEM = Clockwork.item:New();
ITEM.name = "2102: Lonely Ranger";
ITEM.uniqueID = "2102";
ITEM.cost = 42;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = false;
ITEM.description = "Cassette with a Universal Logo and a serie number. Sketched by: Elijah Wilson. Approved by: Dr. Tulip Asterfield.";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("2102: Lonely Ranger", {
        {
            name = "Blue Moon",
            length = 196,
            url = "https://dl.dropboxusercontent.com/s/rc6clb4yn6hgl49/Fallout_%20New%20Vegas%20-%20Soundtrack%20-%20Blue%20Moon%20by%20Frank%20Sinatra.mp3?dl=0"
        },
        {
            name = "Jingle Jangle Jingle",
            length = 199,
            url = "https://dl.dropboxusercontent.com/s/tyosalmac5nbyi8/Kay%20Kyser%20-%20Jingle%20Jangle%20Jingle.mp3?dl=0"
        },
        {
            name = "In The Shadow Of The Valley",
            length = 189,
            url = "https://dl.dropboxusercontent.com/s/dvti2p9td42gshv/Lost%20Weekend%20Western%20Swing%20Band%20-%20In%20the%20Shadow%20of%20the%20Valley.mp3?dl=0"
        },
        {
            name = "Heartache by the Numbers 50s",
            length = 155,
            url = "https://dl.dropboxusercontent.com/s/dhw78pouvfdhz58/Guy%20Mitchell%20-%20Heartache%20by%20the%20Numbers%2050s.mp3?dl=0"
        },
        {
            name = "Lone Star",
            length = 147,
            url = "https://dl.dropboxusercontent.com/s/d0hdpitdlkcih65/Lone%20Star.mp3?dl=0"
        }

    })

function ITEM:OnDrop(player, position)
end;

ITEM:Register();