-- Called when the plugin is initialized.
function PLUGIN:Initialize()
	-- A function to set a player's forced animation. Overwrites this function.
	FindMetaTable("Player").SetForcedAnimation = function(self, animation, delay, OnAnimate, OnFinish)
		local forcedAnimation = self:GetForcedAnimation();
		local sequence = nil;
		
		if (!animation) then
			self:SetSharedVar("ForceAnim", 0);
			self.cwForcedAnimation = nil;
			
			if (forcedAnimation and forcedAnimation.OnFinish) then
				forcedAnimation.OnFinish(self);
			end;
			
			return false;
		end;
		
		local bIsPermanent = (!delay or delay == 0);
		local bShouldPlay = (!forcedAnimation or forcedAnimation.delay != 0);
		
		if (bShouldPlay) then
			if (type(animation) == "string") then
				sequence = self:LookupSequence(animation);
			else
				sequence = self:SelectWeightedSequence(animation);
			end;

			-- self:SetForcedAnimation();
			
			self.cwForcedAnimation = {
				animation = animation,
				OnAnimate = OnAnimate,
				OnFinish = OnFinish,
				delay = delay
			};
			
			if (bIsPermanent) then
				Clockwork.kernel:DestroyTimer(
					"ForcedAnim"..self:UniqueID()
				);
			else
				self:CreateAnimationStopDelay(delay);
			end;
			
			self:SetSharedVar("ForceAnim", sequence);
			Clockwork.datastream:Start(nil, "ForcedAnimResetCycle", {player = self});
			
			if (forcedAnimation and forcedAnimation.OnFinish) then
				forcedAnimation.OnFinish(self);
			end;
			
			return true;
		end;
	end;
end;