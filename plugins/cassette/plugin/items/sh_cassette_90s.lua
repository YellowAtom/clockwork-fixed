local ITEM = Clockwork.item:New();
ITEM.name = "90's Dance Cassette";
ITEM.uniqueID = "90s_cassette";
ITEM.cost = 25; 
ITEM.model = "models/devcon/mrp/props/casette.mdl"; 
ITEM.weight = .05; 
ITEM.batch = 1; 
ITEM.access = "1"; 
ITEM.category = "Music";
ITEM.business = true; 
ITEM.description = "Your usual white transparent cassette. It has a label saying '90's' on it.";
ITEM.isCassette = true; 
ITEM.key = t_cassette.Register("90s Dance Songs", { 
        {
            name = "Celine Dion - My Heart Will Go On",
            length = 280, 
            url = "https://dl.dropboxusercontent.com/s/8zys764jdej843t/Celine%20Dion%20-%20My%20Heart%20Will%20Go%20On.mp3?dl=0" 
        },
        {
            name = "Eiffel 65 - I'm Blue",
            length = 285,
            url = "https://dl.dropboxusercontent.com/s/i1utvla2q0ys37j/Eiffel%2065%20-%20Blue%20%28Da%20Ba%20Dee%29.mp3?dl=0"
        },
        {
            name = "Londonbeat - I've Been Thinking About You",
            length = 227,
            url = "https://dl.dropboxusercontent.com/s/tijubx3zq9s1u8i/Londonbeat%20-%20I%27ve%20Been%20Thinking%20About%20You.mp3?dl=0"
        },
        {
            name = "O-Zone - Dragostea Din Tei",
            length = 215,
            url = "https://dl.dropboxusercontent.com/s/a3pwh2gsjkvlt7w/O-Zone%20-Dragostea%20Din%20Tei.mp3?dl=0"
        },
        {
            name = "Sash! - Ecuador",
            length = 211,
            url = "https://dl.dropboxusercontent.com/s/9wcar9wgbsl4ury/Sash%21%20-%20Ecuador.mp3?dl=0"
        },
		{
            name = "Scatman John - Scatman",
            length = 210,
            url = "https://dl.dropboxusercontent.com/s/4yhloorjp10lyk3/Scatman%20John%20-%20Scatman.mp3?dl=0"
        },
		{
            name = "Scatman John - Scatman's World",
            length = 225,
            url = "https://dl.dropboxusercontent.com/s/w7w919z3eublz5x/Scatman%27s%20World.mp3?dl=0"
        }
		,{
            name = "Will Smith - Men In Black",
            length = 285,
            url = "https://dl.dropboxusercontent.com/s/qotr9w9euckahee/Will%20Smith%20-%20Men%20In%20Black.mp3?dl=0"
        }
    })
-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;

ITEM:Register();