local ITEM = Clockwork.item:New();
ITEM.name = "'Those Days #01' Cassette";
ITEM.uniqueID = "those_days_cassette";
ITEM.cost = 31; -- Increase to whatever.
ITEM.model = "models/devcon/mrp/props/casette.mdl"; -- This modifies the cassettes model and shouldn't be touched.
ITEM.weight = .05; -- Weight in kg.
ITEM.batch = 1; -- LEAVE!
ITEM.access = "1"; -- What flag has access to buy it from the business menu, 1 is the General Goods permit, v is light BMD, which sells illegal cassettes.
ITEM.category = "Music";
ITEM.business = true; -- Buyable from the business menu or not.
ITEM.description = "A somewhat faded cassette, with a grayish torn label reading 'Those days #01' in a handwritten bold fashion. Likely someone's personal cassette, once.";
ITEM.isCassette = true; -- DON'T TOUCH!
ITEM.key = t_cassette.Register("Those Days #01", { -- Name that the cassette UI will show.
        {
            name = "T1-Girl",
            length = 194, -- Length of song in seconds.
            url = "https://dl.dropboxusercontent.com/s/n4r4cyduhsjd7cj/G.mp3?dl=0" -- Upload your file to dropbox, you need to replace the start of the default share link it gives you with https://dl.dropboxusercontent.com
        },
        {
            name = "T2-Forever",
            length = 159,
            url = "https://dl.dropboxusercontent.com/s/03if5x039abn0vx/F.mp3?dl=0"
        },
        {
            name = "T3-Sleepwalk",
            length = 151,
            url = "https://dl.dropboxusercontent.com/s/g8daprb4nxnxtxd/Sleepwalk.mp3?dl=0"
        },
        {
            name = "T4-September Song",
            length = 158,
            url = "https://dl.dropboxusercontent.com/s/t7n5ajwogkbgg9a/September%20Song.mp3?dl=0"
        },
        {
            name = "T5-Summertime",
            length = 166,
            url = "https://dl.dropboxusercontent.com/s/61gr5s1zipd4xj1/Summertime%20%281%29.mp3?dl=0"
        },
        {
            name = "T6-Down&Out",
            length = 304,
            url = "https://dl.dropboxusercontent.com/s/khpf8cl7lrs0iuv/Scrapper%20Blackwell%20-%20Nobody%20Knows%20You%20When%20You%27re%20Down%20and%20Out.mp3?dl=0"
        },
        {
            name = "T7-Where'dYouSleepLastNight",
            length = 187,
            url = "https://dl.dropboxusercontent.com/s/pkogbwkp5cf398l/Leadbelly%20-%20Where%20Did%20you%20Sleep%20Last%20Night.mp3?dl=0"
        },
        {
            name = "T8-&ILoveHer",
            length = 131,
            url = "https://dl.dropboxusercontent.com/s/67v7ynu7trya8u9/And%20I%20Love%20Her.mp3?dl=0"
        },
        {
            name = "T9-IWillWaitForYou",
            length = 189,
            url = "https://dl.dropboxusercontent.com/s/aw6lb5snoto2srg/Connie%20Francis%20-%20I%20Will%20Wait%20For%20You.mp3?dl=0"
        },
        {
            name = "T0-EndOfTheWorld",
            length = 157,
            url = "https://dl.dropboxusercontent.com/s/a6yxj7xmusghxj6/The%20End%20of%20the%20World.mp3?dl=0"
        }

    })

-- If you want to add more music, create a new open bracket {, make sure to close it with a closed bracket }.
function ITEM:OnDrop(player, position)
end;

ITEM:Register();