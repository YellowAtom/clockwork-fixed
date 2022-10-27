local ITEM = Clockwork.item:New();
ITEM.name = "Bizarre Cassette";
ITEM.uniqueID = "jojo_cassette";
ITEM.cost = 46; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A black cassette with a picture of a purple star drawn onto the front";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Bizarre Casette", { -- Name that the cassette UI will show.
        {
            name = "Victory Theme",
            length = 208, -- Length of song in seconds.
            url = "https://www.dropbox.com/s/771x8yznel9pyxs/JoJos%20Bizarre%20Adventure%20Phantom%20Blood%20Ost%2024%20%5BFukutsu%20~Mushin%20no%20Sakebi~%5D.mp3?dl=0"
        },
        {
            name = "Overdrive",
            length = 208,
            url = "https://www.dropbox.com/s/3oq4920x69t27f1/Jojos%20Bizarre%20Adventure%20OST%20Track%2021%20-%20Overdrive.mp3?dl=0"
        },
        {
            name = "Stardust Crusaders",
            length = 304,
            url = "https://www.dropbox.com/s/hdc7vvqc8s7coto/JoJos%20Bizarre%20Adventure%20Stardust%20Crusaders%20OST%20-%20Stardust%20Crusaders.mp3?dl=0"
        },
        {
            name = "Diamond is Unbreakable",
            length = 240,
            url = "https://www.dropbox.com/s/xtb19ooj9b2mfav/JoJos%20Bizarre%20Adventure%20Diamond%20is%20Unbreakable%20OST%20-%20Diamond%20is%20Unbreakable.mp3?dl=0"
        },
        {
            name = "Il vento d'oro",
            length = 271,
            url = "https://www.dropbox.com/s/m57bx9nag1ps7bk/JoJos%20Bizarre%20AdventureGolden%20Wind%20OST%20~Main%20Theme~%20%28OFFICAL%29.mp3?dl=0"
        }
 
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();