fbhStatus = {}
local addonVersion = 1.1
local posX, posY = -1, -1

fbh_guiFrame = CreateFrame('Frame', "FastBuff_Status", UIParent)
fbh_guiFrame:SetSize(fbh_width, 15)
fbh_guiFrame:SetBackdrop({
      bgFile = 'Interface/FrameGeneral/UI-Background-Rock',
      edgeFile = 'Interface/DialogFrame/UI-DialogBox-Border',
      tile = true, tileSize = 192, edgeSize = 16,
      insets = {left = 4, right = 4, top = 4, bottom = 4}})
fbh_guiFrame:ClearAllPoints()
fbh_guiFrame:SetPoint('LEFT', 52, 0)
fbh_guiFrame:EnableMouse(true)
fbh_guiFrame:SetMovable(true)
fbh_guiFrame:SetScript('OnMouseDown', function(self)
    self:StartMoving()
end)

fbh_guiFrame:SetScript('OnMouseUp', function(self)
    self:StopMovingOrSizing()
end)

-- fbh_nameFrame = CreateFrame('Frame', nil, fbh_guiFrame)
-- fbh_nameFrame:SetSize(100, 15)
-- fbh_nameFrame:ClearAllPoints()
-- fbh_nameFrame:SetPoint('TOPLEFT', 0, 0)
-- fbh_nameFrame:SetText('NAME')

-- fbh_statusFrame = CreateFrame('Frame', nil, fbh_guiFrame)
-- fbh_statusFrame:SetSize(fbh_width - 100, 15)
-- fbh_statusFrame:ClearAllPoints()
-- fbh_statusFrame:SetPoint('TOPLEFT', 100, 0)
-- fbh_statusFrame:SetText('STATUS')



local reload = CreateFrame('Button', nil, fbh_guiFrame, 'GameMenuButtonTemplate')
reload:SetSize(80, 24)
reload:ClearAllPoints()
reload:SetPoint('BOTTOM', 0, -38)
reload:SetText('ReloadUI')
reload:SetScript("OnClick", ReloadUI)
reload:Hide()

statusName = fbh_guiFrame:CreateFontString()
statusName:SetFontObject("GameFontNormalLarge")
statusName:ClearAllPoints()
statusName:SetPoint('TOPLEFT', 10, -15)
statusName:SetJustifyH("LEFT")

statusText = fbh_guiFrame:CreateFontString()
statusText:SetFontObject("GameFontNormalLarge")
statusText:ClearAllPoints()
statusText:SetPoint('LEFT', statusName, 'RIGHT', 30, 0)
statusName:SetJustifyH("RIGHT")

local tabFrame = CreateFrame('Frame', nil, fbh_guiFrame)
tabFrame:SetSize(fbh_width, 24)
tabFrame:SetPoint('TOP', 0, 18)
tabFrame:SetFrameLevel(fbh_guiFrame:GetFrameLevel()-1)
tabFrame:EnableMouse(true)
tabFrame:SetScript('OnMouseDown', function()
    fbh_guiFrame:StartMoving()
end)

tabFrame:SetScript('OnMouseUp', function()
    fbh_guiFrame:StopMovingOrSizing()
end)

tabFrame.l = tabFrame:CreateTexture(nil, 'BACKGROUND')
tabFrame.l:SetTexture("Interface\\ChatFrame\\ChatFrameTab")
tabFrame.l:SetSize(8, 1)
tabFrame.l:ClearAllPoints()
tabFrame.l:SetPoint('LEFT')
tabFrame.l:SetPoint('TOP')
tabFrame.l:SetPoint('BOTTOM')
tabFrame.l:SetTexCoord(0.03125, 0.140625, 0.28125, 1.0)

tabFrame.m = tabFrame:CreateTexture(nil, 'BACKGROUND')
tabFrame.m:SetTexture("Interface\\ChatFrame\\ChatFrameTab")
tabFrame.m:SetSize(fbh_width - 16, 1)
-- tabFrame.m:SetSize(264, 1)
tabFrame.m:ClearAllPoints()
tabFrame.m:SetPoint('LEFT', tabFrame.l, 'RIGHT')
tabFrame.m:SetPoint('TOP')
tabFrame.m:SetPoint('BOTTOM')
tabFrame.m:SetTexCoord(0.140625, 0.859375, 0.28125, 1.0)

tabFrame.r = tabFrame:CreateTexture(nil, 'BACKGROUND')
tabFrame.r:SetTexture("Interface\\ChatFrame\\ChatFrameTab")
tabFrame.r:SetSize(8, 1)
tabFrame.r:ClearAllPoints()
tabFrame.r:SetPoint('LEFT', tabFrame.m, 'RIGHT')
tabFrame.r:SetPoint('TOP')
tabFrame.r:SetPoint('BOTTOM')
tabFrame.r:SetTexCoord(0.859375, 0.96875, 0.28125, 1.0)

tabFrame.t = tabFrame:CreateFontString()
tabFrame.t:SetFontObject("GameFontNormalLarge")
tabFrame.t:SetPoint('TOP', 0, -6)
tabFrame.t:SetText('FastBuff Helper: Status')
tabFrame.t:SetTextColor(0.25, 0.75, 0.25)

tabFrame.closeButton = CreateFrame('Button', nil, tabFrame, "UIPanelCloseButton")
tabFrame.closeButton:SetSize(24, 24)
tabFrame.closeButton:SetPoint('TOPRIGHT', 0, 0)


tabFrame.closeButton:SetScript('OnClick', function()
--    stopSearching()
    fbh_guiFrame:Hide()
    tabFrame:Show()
end)

SLASH_AUTOCLICKER1 = '/fbh'
SlashCmdList["fbhStatus"] = function(message)
    fbh_show_window()
end

-- fbh_guiFrame:Show()
fbh_show_window()
-- fbh_update_status()
fbh_update_status()



-- statusQuo = fbh_guiFrame:CreateFontString()
-- statusQuo:SetFontObject("GameFontNormalLarge")
-- statusQuo:SetText('Kein Status vorhanden.')
-- statusQuo:ClearAllPoints()
-- statusQuo:SetPoint('TOPLEFT', 10, -15)



-- fbh_guiFrame.glow = fbh_guiFrame:CreateTexture(nil, 'OVERLAY')
-- fbh_guiFrame.glow:SetTexture('Interface/FrameGeneral/UI-Background-Rock')
-- fbh_guiFrame.glow:SetBlendMode('ADD')
-- fbh_guiFrame.glow:SetPoint('TOPLEFT', 6, -6)
-- fbh_guiFrame.glow:SetPoint('BOTTOMRIGHT', -6, 6)
-- fbh_guiFrame.glow:SetAlpha(0)

-- fbh_guiFrame.glowAnimation = fbh_guiFrame.glow:CreateAnimationGroup()
-- fbh_guiFrame.glowAnimation[1] = fbh_guiFrame.glowAnimation:CreateAnimation("Alpha")
-- fbh_guiFrame.glowAnimation[1]:SetDuration(0.25)
-- fbh_guiFrame.glowAnimation[1]:SetFromAlpha(1)
-- fbh_guiFrame.glowAnimation[1]:SetToAlpha(0)


-- local optionsButton = CreateFrame('Button', nil, fbh_guiFrame, 'GameMenuButtonTemplate')
-- optionsButton:SetSize(64, 24)
-- optionsButton:ClearAllPoints()
-- optionsButton:SetPoint('BOTTOMRIGHT', -8, 8)
-- optionsButton:SetText('Config')
-- optionsButton:SetScript('OnClick', function()
    -- InterfaceOptionsFrame_OpenToCategory("FastBuff Helper")
    -- InterfaceOptionsFrame_OpenToCategory("FastBuff Helper")
-- end)
