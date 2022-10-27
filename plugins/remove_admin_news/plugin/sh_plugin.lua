function PLUGIN:Initialize()
	local CLOCKWORK_LOGO_PLUGIN = Clockwork.plugin:GetModules()["ClockworkLogoPlugin"];

	if (!CLOCKWORK_LOGO_PLUGIN) then
		return;
	end;

	function CLOCKWORK_LOGO_PLUGIN:StartIntro()
		local introSound = Clockwork.option:GetKey("intro_sound");

		local soundObject;

		if (introSound != "") then
			soundObject = CreateSound(Clockwork.Client, introSound);

			soundObject:PlayEx(0.3, 100);
		end;

		surface.PlaySound("buttons/button1.wav");

		self:SetIntroActive();

		local duration = 6;

		self:OpenIntroHTML("http://authx.cloudsixteen.com/data/loading/clockwork.php", duration, function()
			return self:LoadSchemaIntro(function()
				self:SetIntroFinished();

				if (soundObject) then
					soundObject:FadeOut(4);
				end;
			end);
		end);
	end;
end;
