local E, L, V, P, G = unpack(ElvUI)
local EP = E.Libs.EP
local UF = E:GetModule("UnitFrames")

local _G = _G
local tinsert = tinsert
local GetAddOnMetadata = _G.C_AddOns and _G.C_AddOns.GetAddOnMetadata
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded

-- Addon Name and Namespace
local addonName, _ = ...
ESM = E:NewModule(addonName, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0", "AceHook-3.0")

-- Settings
ESM.Version = GetAddOnMetadata(addonName, "Version")
ESM.Name = "ElvUI Statusbar Mask"
ESM.Icon = "|TInterface\\Addons\\ElvUI_mMediaTag\\media\\logo\\mmt_icon_round.tga:14:14|t"
ESM.Logo = "Interface\\Addons\\ElvUI_mMediaTag\\media\\logo\\mmt_icon.tga"
ESM.Options = {}

-- Plugin Settings table
local function OptionsTable()
	E.Options.args.ESM = {
		order = 100,
		type = "group",
		name = ESM.Icon .. " " .. ESM.Name,
		args = {
			logo = {
				type = "description",
				name = "",
				order = 1,
				image = function()
					return ESM.Logo, 307, 154
				end,
			},
			about = {
				order = 2,
				type = "group",
				inline = true,
				name = L["About"],
				args = {
					description1 = {
						order = 1,
						type = "description",
						name = format("%s is a layout for ElvUI.", ESM.Name),
					},
					spacer1 = {
						order = 2,
						type = "description",
						name = "\n",
					},
					discord = {
						order = 3,
						type = "execute",
						name = L["Discord"],
						func = function()
							E:StaticPopup_Show("ESM_EDITBOX", nil, nil, "https://discord.gg/AE9XebMU49")
						end,
					},
				},
			},
			thankyou = {
				order = 6,
				type = "group",
				inline = true,
				name = L["Credits"],
				args = {
					desc = {
						order = 1,
						type = "description",
						fontSize = "medium",
						name = "CREDITS_STRING",
					},
				},
			},
		},
	}
end

-- add the settings to our main table
tinsert(ESM.Options, OptionsTable)

local function CreateBarMask(unitFrame)
	local mask = unitFrame:CreateMaskTexture()
	mask:SetTexture(
		"Interface\\AddOns\\ElvUI_Statusbar_Mask\\media\\mask_a",
		"CLAMPTOBLACKADDITIVE",
		"CLAMPTOBLACKADDITIVE"
	)
	mask:SetAllPoints(unitFrame.healthBar)

	unitFrame.healthBar:GetStatusBarTexture():AddMaskTexture(mask)
end

local function ApplyMaskToBar(unitFrame)
	if not unitFrame.healthBar.maskApplied then
		CreateBarMask(unitFrame)
		unitFrame.healthBar.maskApplied = true
	end
end

local function HideBackdrop(frame)
	frame.backdrop:Hide()
	mMT:DebugPrintTable(frame, nil, true)
end

local function AddMaskToHealth(frame)
	if not frame.mask then
		HideBackdrop(frame)

		frame.mask = frame:CreateMaskTexture()
		frame.mask:SetAllPoints(frame)
		frame:GetStatusBarTexture():AddMaskTexture(frame.mask)
		frame.mask:SetTexture( "Interface\\AddOns\\ElvUI_Statusbar_Mask\\media\\mask_c", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE" )
	end
end

local function AddMaskToPower(frame)
	if not frame.mask then
		HideBackdrop(frame)

		frame.mask = frame:CreateMaskTexture()
		frame.mask:SetAllPoints(frame)
		frame:GetStatusBarTexture():AddMaskTexture(frame.mask)
		frame.BG:AddMaskTexture(frame.mask)
		frame.mask:SetTexture( "Interface\\AddOns\\ElvUI_Statusbar_Mask\\media\\mask_a", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE" )
	end
end

local function LoadOptions()
	for _, func in pairs(ESM.Options) do
		func()
	end
end

function ESM:Initialize()
	EP:RegisterPlugin(addonName, LoadOptions)

	if not ESM.healthHook then
		hooksecurefunc(UF, "PostUpdateHealth", AddMaskToHealth)
		hooksecurefunc(UF, "PostUpdatePower", AddMaskToPower)
		ESM.healthHook = true
	end
end

local function CallbackInitialize()
	ESM:Initialize()
end

E:RegisterModule(ESM:GetName(), CallbackInitialize)
