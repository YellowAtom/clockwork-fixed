# Clockwork - Undetermined Edit
An extensive edit to Clockwork 0.101 with CloudAuthX competely removed, a visual style closer to 0.93 with derma fixes, general optimizations, proper code formatting, new features such as single file entities and a more modern approch to internal solutions. The framework files and default plugins are all modified. This was orignally made for Undetermined Gaming, but as that project was never completed it is now public.

## Installation
> Support for modern versions of tmysql4 is currently broken! Use the version [here](https://github.com/CloudSixteen/Clockwork/tree/master/upload/garrysmod/lua/bin) or use mysqloo.

Unlike regular Clockwork the installation procedure is a lot cleaner. 
- Place this repository as a gamemode named clockwork in `garrysmod/gamemodes` and do the same for a schema gamemode (e.g HL2 RP). The schema gamemode is the one that actually gets loaded.
- At `garrysmod/lua/bin` place the .dll of either [mysqloo](https://github.com/FredyH/MySQLOO/releases) or [tmysql4](https://github.com/SuperiorServers/gm_tmysql4/releases) as well as [cwutils](https://www.dropbox.com/sh/dpdvc2ax04zghh1/AADAobyoYcEjjQ1ynoNzlrqFa?dl=0).
- Configure `gamemodes/clockwork/clockwork.cfg` with your database settings, "mysqloo", "tmysql4" and "sqlite" are available as adapters, the first two must be installed as stated above.
- Finally make sure that your server and client are subscribed to the [workshop content](https://steamcommunity.com/sharedfiles/filedetails/?id=2892883208).

## Compatibility
This version of clockwork has compatability for anything that worked with version 0.101. Most 0.93 plugins work but 0.93 schemas and ealier often do not load or will not function correctly. Note that clockwork can only run on win32 or linux servers.

## Credits
### Development Team
- [YellowAtom](https://github.com/YellowAtom) - Lead Developer
- [Pandafish](https://github.com/Awoowogei)
### External
- [Homonovus](https://github.com/homonovus) - Bug Fixes and full CloudAuthX removal.
### Previous
- [Cloud Sixteen](https://github.com/CloudSixteen) - Orignal Clockwork.
