local ITEM = Clockwork.item:New();
ITEM.name = "Battle Tapes";
ITEM.uniqueID = "battle_tapes";
ITEM.cost = 125;
ITEM.model = "models/devcon/mrp/props/casette.mdl";
ITEM.weight = .05;
ITEM.batch = 1;
ITEM.access = "1";
ITEM.category = "Music";
ITEM.business = true;
ITEM.description = "A Black Cassette Tape bearing what appears to be four upside-down V's overlaping on the left side, in the center of the Cassette Tape";
ITEM.isCassette = true;
ITEM.key = t_cassette.Register("Battle Tapes", {
        {
            name = "Battle Tapes - Weight of the World",
            length = 244,
            url = "https://dl.dropboxusercontent.com/s/bykvmggng98glzl/Battle%20Tapes%20-%20Weight%20of%20the%20World.mp3?dl=0"
        },
        {
            name = "Battle Tapes - Alive",
            length = 307,
            url = "https://dl.dropboxusercontent.com/s/6li0y8w3f60ih8j/Battle%20Tapes%20-%20Alive.mp3?dl=0"
        },
        {
            name = "Battle Tapes - Rhyme or Reason",
            length = 277,
            url = "https://dl.dropboxusercontent.com/s/d0kq5yftgicl6qv/Battle%20Tapes%20-%20Rhyme%20or%20Reason.mp3?dl=0"
        },
        {
            name = "Battle Tapes - Control",
            length = 190,
            url = "https://dl.dropboxusercontent.com/s/dkgijtjduq7vphw/Battle%20Tapes%20-%20Control.mp3?dl=0"
        },
        {
            name = "Battle Tapes - Last Resort and Spa",
            length = 254,
            url = "https://dl.dropboxusercontent.com/s/rhgmy7mdm1auebz/Battle%20Tapes%20-%20Last%20Resort%20and%20Spa.mp3?dl=0"
        },
        {
            name = "Battle Tapes - Sweatshop Boys",
            length = 238,
            url = "https://dl.dropboxusercontent.com/s/rwupyazyxckdti7/Battle%20Tapes%20-%20Sweatshop%20Boys.mp3?dl=0"
        },
        {
             name = "Battle Tapes - Feel the Same",
            length = 277,
            url = "https://dl.dropboxusercontent.com/s/wzwtc3iwdl676ox/Battle%20Tapes%20-%20Feel%20the%20Same.mp3?dl=0"
        },
        {
             name = "Battle Tapes - Sleepwalker",
            length = 244,
            url = "https://dl.dropboxusercontent.com/s/mk59r876qfwx31g/Battle%20Tapes%20-%20Sleepwalker.mp3?dl=0"
        },
        {
             name = "Battle Tapes - Sleepwalker Pt II",
            length = 242,
            url = "https://dl.dropboxusercontent.com/s/5acvxzocxph4bog/Battle%20Tapes%20-%20Sleepwalker%20Pt%20II.mp3?dl=0"
        },
        {
             name = "Battle Tapes - Sleepwalker Pt III",
            length = 393,
            url = "https://dl.dropboxusercontent.com/s/ovye9a5uwh3npm7/Battle%20Tapes%20-%20Sleepwalker%20Pt%20III.mp3?dl=0"
        }
 
    })
function ITEM:OnDrop(player, position)
end;
 
ITEM:Register();