local ITEM = Clockwork.item:New();
ITEM.name = "Experimental Cassette Vol. 1";
ITEM.uniqueID = "cassette_exp";
ITEM.cost = 25; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A matte black cassette with an orange stripe. It has a label on it, saying 'Experimental' as well as the small Universal Union insignia on it. It sounds oddly familiar and nostalgic.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Experimental Cassette Vol. 1", { -- Name that the cassette UI will show.
        {
            name = "Amon Tobin - Bridge",
            length = 356, 
            url = "https://dl.dropboxusercontent.com/s/chkyhhc0cuy72zc/Amon%20Tobin%20-%20Bridge.mp3?dl=0" 
        },
        {
            name = "Amon Tobin - Reanimator",
            length = 394,
            url = "https://dl.dropboxusercontent.com/s/kqkorg135ecrm3v/Amon%20Tobin%20-%20Reanimator.mp3?dl=0"
        },
        {
            name = "Aphex Twin - Hedphelym",
            length = 363,
            url = "https://dl.dropboxusercontent.com/s/ofpf1ytgjhuu6lh/Aphex%20Twin%20-%20Hedphelym.mp3?dl=0"
        },
        {
            name = "Aphex Twin - Xtal",
            length = 293,
            url = "https://dl.dropboxusercontent.com/s/1oq4k1vperr06lm/Aphex%20Twin%20-%20Xtal.mp3?dl=0"
        },
        {
            name = "Home - Resonance",
            length = 212,
            url = "https://dl.dropboxusercontent.com/s/oaiiw5onsjfq5mi/Home%20-%20Resonance.mp3?dl=0"
        }

    })

function ITEM:OnDrop(player, position)
end;

ITEM:Register();