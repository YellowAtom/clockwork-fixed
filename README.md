This is a fork of [Clockwork](https://github.com/cloudsixteen/clockwork) by [Cloud Sixteen](https://github.com/CloudSixteen).

# Clockwork - Undetermined Edit
A full edit of Clockwork 0.101 with CloudAuthX competely removed, derma fixes, general optimizations, proper code formatting for readability, new features such as single file entities and a more modern approch to internal challenges. The framework files and default plugins are all modified. This was orignally made for Undetermined Gaming but is now public.

## Installation
> Modern versions of mysqloo and tmysql4 both have issues, I recommend using the old version of tmysql4 from official clockwork [here](https://github.com/CloudSixteen/Clockwork/tree/master/upload/garrysmod/lua/bin).
- Place this repository in a folder named "clockwork" in `garrysmod/gamemodes` and a second folder called the schema's name containing the schema gamemode, e.g [cwhl2rp](https://github.com/homonovus/hl2rp). Load the schema gamemode through srcds.
- At `garrysmod/lua/bin` place the .dll of either [mysqloo](https://github.com/FredyH/MySQLOO/releases) or [tmysql4](https://github.com/SuperiorServers/gm_tmysql4/releases). The [cwutils](https://drive.proton.me/urls/G141WMAYD0#MJMrah1HNEZx) binary is required and is compiled from [FileIO](https://github.com/alexgrist/gmsv_fileio) which would also work, alternatively the [orignal CloudAuthX binary](https://github.com/CloudSixteen/Clockwork/tree/master/upload/garrysmod/lua/bin) contains this functionality.
- Configure `gamemodes/clockwork/clockwork.cfg` with your database settings, "mysqloo", "tmysql4" and "sqlite" are available as adapters, the first two must be installed as stated above.
- Finally make sure that your server and client are subscribed to the [workshop content](https://steamcommunity.com/sharedfiles/filedetails/?id=2892883208).

## Compatibility
This version of clockwork has compatability for anything that worked with version 0.101. Most 0.93 plugins work but 0.93 schemas and ealier often do not load or will not function correctly. Note that clockwork can only run on 32 Bit windows or linux servers.

## Credits
- Github contributors.
- [Homonovus](https://github.com/homonovus) - Bug Fixes and CloudAuthX dependency removal.
- [Cloud Sixteen](https://github.com/CloudSixteen) - Orignal Clockwork.
