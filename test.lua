local function testi(self,b,c,d,e)
    mMT:Print(self,b,c,d,e)
    mMT:DebugPrintTable(self)
    if not self.mask then
        self.mask = self:CreateMaskTexture()
        self.mask:SetAllPoints(self)
        self:GetStatusBarTexture():AddMaskTexture(self.mask)
        self.mask:SetTexture("Interface\\Addons\\HPTEST\\test", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    end
end


hooksecurefunc(UF, "PostUpdateHealth", testi)

--PostUpdateHealth

-- if _G.ElvUF_Player_HealthBar then
-- 	mMT:DebugPrintTable(_G.ElvUF_Player_HealthBa)
-- 	if not _G.ElvUF_Player_HealthBar.maks then
-- 		_G.ElvUF_Player_HealthBar.mask = _G.ElvUF_Player_HealthBar:CreateMaskTexture()
-- 		_G.ElvUF_Player_HealthBar.mask:SetAllPoints(_G.ElvUF_Player_HealthBar)
-- 		_G.ElvUF_Player_HealthBar:AddMaskTexture(_G.ElvUF_Player_HealthBar)
-- 	end
-- 	_G.ElvUF_Player_HealthBar.mask:SetTexture("Interface\\Addons\\HPTEST\\test", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
-- end
