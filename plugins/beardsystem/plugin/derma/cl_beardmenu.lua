local PANEL = {};

function PANEL:Init()
	self:SetTitle( "Shaving" )
	self:SetSize( 600, 500 )
	self:Center()
	self:MakePopup()
	self:ShowCloseButton(false)
	self:SetDeleteOnClose(true)
	self:SetDraggable( false )

	local y = self:GetTall()/1.6-(ScrH() * 0.370)
	local x = self:GetWide()/2-(ScrW() * 0.104)

	self.icon = vgui.Create( "DModelPanel", self );
	self.icon:SetSize( ScrW() * 0.364, ScrH() * 0.648);
	self.icon:SetPos( x, y );
	self.icon:SetModel( beardTarget:GetModel() );
	self.icon.Angles = Angle( 0, 0, 0 );
	self.icon:GetEntity():SetSkin(beardTarget:GetSkin());
	self.icon:GetEntity():SetSequence(1);

	self.closeButton = vgui.Create( "DButton", self )

	self.closeButton:SetText( "" )
	self.closeButton:SetPos( 580, 0 )
	self.closeButton:SetSize( 20, 20 )
	self.closeButton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 75 ) )
	end
	function self.icon:DragMousePress()
		self.PressX, self.PressY = gui.MousePos();
		self.Pressed = true;
	end;

	function self.icon:DragMouseRelease() self.Pressed = false; end;

	function self.icon:LayoutEntity( ent )
		self:RunAnimation();

		if ( self.Pressed ) then
			local mx = gui.MousePos();
			self.Angles = self.Angles - Angle( 0, ( ( self.PressX or mx ) - mx ) / 2, 0 );

			self.PressX, self.PressY = gui.MousePos();
		end

		local tr = util.QuickTrace(self:GetEntity():EyePos(), self:GetEntity():EyePos() + self:GetEntity():GetForward() * 10000)
		self:GetEntity():SetEyeTarget(tr.HitPos);

		ent:SetAngles( self.Angles );
	end;

	local headpos = self.icon.Entity:GetBonePosition( self.icon.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
	self.icon:SetCamPos( headpos-Vector( -15, 0, 0 ) )	-- Move cam in front of face
	self.icon:SetLookAt( headpos )
	local tr = util.QuickTrace(self.icon:GetEntity():EyePos(), self.icon:GetEntity():EyePos() + self.icon:GetEntity():GetForward() * 10000)
	self.icon:GetEntity():SetEyeTarget( tr.HitPos );
	self.icon:GetEntity():SetBodygroup(1, beardTarget:GetBodygroup( 1 ))
	self.icon:GetEntity():SetBodygroup(2, beardTarget:GetBodygroup( 2 ))
	self.icon:GetEntity():SetBodygroup(3, beardTarget:GetBodygroup( 3 ))
	self.icon:GetEntity():SetBodygroup(4, beardTarget:GetBodygroup( 4 ))
	self.icon:GetEntity():SetBodygroup(5, beardTarget:GetBodygroup( 5 ))
	self.icon:GetEntity():SetBodygroup(6, beardTarget:GetBodygroup( 6 ))
	self.icon:GetEntity():SetBodygroup(7, beardTarget:GetBodygroup( 7 ))
	self.icon:GetEntity():SetBodygroup(8, beardTarget:GetBodygroup( 8 ))
	self.icon:GetEntity():SetBodygroup(9, beardTarget:GetBodygroup( 9 ))
	self.icon:GetEntity():SetBodygroup(10, beardTarget:GetBodygroup( 10 ))
	self.icon:GetEntity():SetBodygroup(11, beardTarget:GetBodygroup( 11 ))
	self.icon:GetEntity():SetBodygroup(12, beardTarget:GetBodygroup( 12 ))
	self.icon:SetMouseInputEnabled( true )

	local y = self:GetTall()/1.6-340
	local x = self:GetWide()/2-250

	local y = y + 100

	self.comboBox = vgui.Create( "DComboBox", self )
	self.comboBox:SetPos( x, y )
	self.comboBox:SetSize( 250, 50 )
	self.comboBox:SetValue( "Choose your style" )
	self.comboBox:AddChoice( "Handlebar & Chin Puff" )
	self.comboBox:AddChoice( "Copstash" )
	self.comboBox:AddChoice( "Dallas" )
	self.comboBox:AddChoice( "Imperial" )
	self.comboBox:AddChoice( "Petite Goatee" )
	self.comboBox:AddChoice( "Goatee" )

	function self.comboBox:OnSelect(index, value)
		local parent = self:GetParent();

		local SaveOptionA = vgui.Create( "DButton", parent );
		local SaveOptionB = vgui.Create( "DButton", parent );
		local SaveOptionC = vgui.Create( "DButton", parent );
		local SaveOptionD = vgui.Create( "DButton", parent );
		local SaveOptionE = vgui.Create( "DButton", parent );
		local SaveOptionF = vgui.Create( "DButton", parent );
		
		if value == "Handlebar & Chin Puff" then
			parent.icon:GetEntity():SetBodygroup( 12, 1)
			SaveOptionB:Remove()
			SaveOptionC:Remove()
			SaveOptionD:Remove()
			SaveOptionE:Remove()
			SaveOptionF:Remove()
			SaveOptionA:SetText( "Save Beard" )
			SaveOptionA:SetTextColor(Color(180, 180, 180, 255));
			SaveOptionA:SetPos( parent:GetWide()/2-250, parent:GetTall()/1.6-190 )
			SaveOptionA:SetSize( 250, 50 )
			SaveOptionA.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30, 255) )
			end
			SaveOptionA.PaintOver = function( self, w, h )
				surface.SetDrawColor(100, 100, 100, 100)
				
				for i = 1, 3 do
					surface.DrawRect(0, h - 2, w, 2);
				end
			end
		elseif value == "Copstash" then
			parent.icon:GetEntity():SetBodygroup( 12, 2)
			SaveOptionA:Remove()
			SaveOptionC:Remove()
			SaveOptionD:Remove()
			SaveOptionE:Remove()
			SaveOptionF:Remove()
			SaveOptionB:SetText( "Save Beard" )
			SaveOptionB:SetTextColor(Color(180, 180, 180, 255));
			SaveOptionB:SetPos( parent:GetWide()/2-250, parent:GetTall()/1.6-190 )
			SaveOptionB:SetSize( 250, 50 )
			SaveOptionB.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30, 255) )
			end
			SaveOptionB.PaintOver = function( self, w, h )
				surface.SetDrawColor(100, 100, 100, 100)
				
				for i = 1, 3 do
					surface.DrawRect(0, h - 2, w, 2);
				end
			end
		elseif value == "Dallas" then
			parent.icon:GetEntity():SetBodygroup( 12, 3)
			SaveOptionA:Remove()
			SaveOptionB:Remove()
			SaveOptionD:Remove()
			SaveOptionE:Remove()
			SaveOptionF:Remove()
			SaveOptionC:SetText( "Save Beard" )
			SaveOptionC:SetTextColor(Color(180, 180, 180, 255));
			SaveOptionC:SetPos( parent:GetWide()/2-250, parent:GetTall()/1.6-190 )
			SaveOptionC:SetSize( 250, 50 )
			SaveOptionC.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30, 255) )
			end
			SaveOptionC.PaintOver = function( self, w, h )
				surface.SetDrawColor(100, 100, 100, 100)
				
				for i = 1, 3 do
					surface.DrawRect(0, h - 2, w, 2);
				end
			end
		elseif value == "Imperial" then
			parent.icon:GetEntity():SetBodygroup( 12, 4)
			SaveOptionA:Remove()
			SaveOptionB:Remove()
			SaveOptionC:Remove()
			SaveOptionE:Remove()
			SaveOptionF:Remove()
			SaveOptionD:SetText( "Save Beard" )
			SaveOptionD:SetTextColor(Color(180, 180, 180, 255));
			SaveOptionD:SetPos( parent:GetWide()/2-250, parent:GetTall()/1.6-190 )
			SaveOptionD:SetSize( 250, 50 )
			SaveOptionD.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30, 255) )
			end
			SaveOptionD.PaintOver = function( self, w, h )
				surface.SetDrawColor(100, 100, 100, 100)
				
				for i = 1, 3 do
					surface.DrawRect(0, h - 2, w, 2);
				end
			end
		elseif value == "Petite Goatee" then
			parent.icon:GetEntity():SetBodygroup( 12, 6)
			SaveOptionA:Remove()
			SaveOptionB:Remove()
			SaveOptionC:Remove()
			SaveOptionD:Remove()
			SaveOptionF:Remove()
			SaveOptionE:SetText( "Save Beard" )
			SaveOptionE:SetTextColor(Color(180, 180, 180, 255));
			SaveOptionE:SetPos( parent:GetWide()/2-250, parent:GetTall()/1.6-190 )
			SaveOptionE:SetSize( 250, 50 )
			SaveOptionE.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30, 255) )
			end
			SaveOptionE.PaintOver = function( self, w, h )
				surface.SetDrawColor(100, 100, 100, 100)
				
				for i = 1, 3 do
					surface.DrawRect(0, h - 2, w, 2);
				end
			end
		elseif value == "Goatee" then
			parent.icon:GetEntity():SetBodygroup( 12, 7)
			SaveOptionA:Remove()
			SaveOptionB:Remove()
			SaveOptionC:Remove()
			SaveOptionD:Remove()
			SaveOptionE:Remove()
			SaveOptionF:SetText( "Save Beard" )
			SaveOptionF:SetTextColor(Color(180, 180, 180, 255));
			SaveOptionF:SetPos( parent:GetWide()/2-250, parent:GetTall()/1.6-190 )
			SaveOptionF:SetSize( 250, 50 )
			SaveOptionF.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color(30, 30, 30, 255) )
			end
			SaveOptionF.PaintOver = function( self, w, h )
				surface.SetDrawColor(100, 100, 100, 100)
				
				for i = 1, 3 do
					surface.DrawRect(0, h - 2, w, 2);
				end
			end
		else
			print( value .." was selected at index " .. index )
		end
		
		local function Shaving()
			ShavingWait = vgui.Create( "DFrame" )
			ShavingWait:SetTitle( "Shaving - Please wait" )
			ShavingWait:SetSize( 200, 100 )
			ShavingWait:Center()
			ShavingWait:MakePopup()
			ShavingWait:ShowCloseButton(false)
			ShavingWait:SetDeleteOnClose(true)
			ShavingWait:SetDraggable( false )
			ShavingWait.Paint = function( self, w, h )
				surface.SetDrawColor(Color(40, 40, 40, 255));
				surface.DrawRect(0,0, w, h);
				
				surface.SetDrawColor(Color(100, 100, 100, 100));
				surface.DrawOutlinedRect(0, 0, w, h);
			end
		end
		
		SaveOptionA.DoClick = function(self)
			local parent = self:GetParent();
			parent:Close()
			parent.icon:Remove()
			SaveOptionA:Remove()
			surface.PlaySound( "npc/antlion/idle1.wav" )
			Shaving()
			timer.Simple(5, function()
			Clockwork.datastream:Start("ShaveBeard", {target = beardTarget, style = STYLE_HANDLEBAR})
			beardTarget = nil;
			ShavingWait:Remove()
			end)
		end
		
		SaveOptionB.DoClick = function(self)
			local parent = self:GetParent();
			parent:Close()
			parent.icon:Remove()
			SaveOptionB:Remove()
			surface.PlaySound( "npc/antlion/idle1.wav" )
			Shaving()
			timer.Simple(5, function()
			Clockwork.datastream:Start("ShaveBeard", {target = beardTarget, style = STYLE_COPSTASH})
			beardTarget = nil;
			ShavingWait:Remove()
			end)
		end
		
		SaveOptionC.DoClick = function(self)
			local parent = self:GetParent();
			parent:Close()
			parent.icon:Remove()
			SaveOptionC:Remove()
			surface.PlaySound( "npc/antlion/idle1.wav" )
			Shaving()
			timer.Simple(5, function()
			Clockwork.datastream:Start("ShaveBeard", {target = beardTarget, style = STYLE_DALLAS})
			beardTarget = nil;
			ShavingWait:Remove()
			end)
		end

		SaveOptionD.DoClick = function(self)
			local parent = self:GetParent();
			parent:Close()
			parent.icon:Remove()
			SaveOptionD:Remove()
			surface.PlaySound( "npc/antlion/idle1.wav" )
			Shaving()
			timer.Simple(5, function()
			Clockwork.datastream:Start("ShaveBeard", {target = beardTarget, style = STYLE_IMPERIAL})
			beardTarget = nil;
			ShavingWait:Remove()
			end)
		end
		
		SaveOptionE.DoClick = function(self)
			local parent = self:GetParent();
			parent:Close()
			parent.icon:Remove()
			SaveOptionE:Remove()
			surface.PlaySound( "npc/antlion/idle1.wav" )
			Shaving()
			timer.Simple(5, function()
			Clockwork.datastream:Start("ShaveBeard", {target = beardTarget, style = STYLE_SMALLGOATEE})
			beardTarget = nil;
			ShavingWait:Remove()
			end)
		end
		
		SaveOptionF.DoClick = function(self)
			local parent = self:GetParent();
			parent:Close()
			parent.icon:Remove()
			SaveOptionF:Remove()
			surface.PlaySound( "npc/antlion/idle1.wav" )
			Shaving()
			timer.Simple(5, function()
			Clockwork.datastream:Start("ShaveBeard", {target = beardTarget, style = STYLE_GOATEE})
			beardTarget = nil;
			ShavingWait:Remove()
			end)
		end
	end;

	function self.closeButton:DoClick()
		local parent = self:GetParent();
		parent:Close()
		parent.icon:Remove()
		Clockwork.option:PlaySound("click");
	end;		
end;

function PANEL:Paint(w, h)
	surface.SetDrawColor(Color(40, 40, 40, 200));
	surface.DrawRect(0,0, w, h);
	
	surface.SetDrawColor(Color(100, 100, 100, 100));
	surface.DrawOutlinedRect(0, 0, w, h);
end;

function PANEL:Think()
	if (beardTarget == Clockwork.Client) then return; end;

	local entity = Clockwork.Client:GetEyeTraceNoCursor().Entity;

	if (IsValid(entity) and entity == beardTarget and Clockwork.Client:GetPos():DistToSqr(entity:GetPos()) <= 192*192) then
		return;
	end;

	self:Close();
	self.icon:Remove();
end;

vgui.Register("cwBeardMenu", PANEL, "DFrame");
