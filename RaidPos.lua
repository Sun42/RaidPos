CLASSCOLORS = {
	["Warrior"] = {0.68, 0.51, 0.33},
	["Rogue"] = {1.0, 0.96, 0.31},
	["Mage"] = {0.21, 0.60, 0.74},
	["Warlock"] = {0.48, 0.41, 0.69},
	["Hunter"] = {0.47, 0.73, 0.25},
	["Priest"] = {1.0, 1.00, 1.00},
	["Paladin"] = {0.96, 0.55, 0.73},
	["Druid"] = {1.0, 0.49, 0.04},
	["Shaman"] = {0.0, 0.34, 0.77}
}

CURRENT_PLAYERNAME,_ = UnitName("player")
local backdrop = {
	bgFile = "Interface\\AddOns\\RaidPos\\Images\\Kt_Positioning.tga",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = false,
	edgeSize = 32,
	insets = {
		left = 12,
		right = 12,
		top = 12,
		bottom = 12
	}
}

MAIN_FRAME = CreateFrame("Frame", "Kt_room", UIParent)
MAIN_FRAME:EnableMouse(true)
MAIN_FRAME:SetMovable(true)
MAIN_FRAME:SetHeight(534)
MAIN_FRAME:SetWidth(534)
MAIN_FRAME:SetPoint("CENTER", 0, 0)
MAIN_FRAME:SetBackdrop(backdrop)
MAIN_FRAME:SetAlpha(1.00)
MAIN_FRAME:SetUserPlaced(true)
MAIN_FRAME:SetFrameStrata("HIGH")
MAIN_FRAME:RegisterEvent("GROUP_ROSTER_UPDATE")
MAIN_FRAME:SetScript("OnEvent", function()
	clearDots()
	local players = getplayerList()
	players = Translate(players)
	place(players)
end)
MAIN_FRAME:Hide()

local opacity_slider = CreateFrame("Slider", "MySlider1", MAIN_FRAME, "OptionsSliderTemplate")
opacity_slider:SetPoint("BOTTOM", MAIN_FRAME, "BOTTOMLEFT", 110, 20)
opacity_slider:SetMinMaxValues(0.05, 1.00)
opacity_slider:SetValue(1.00)
opacity_slider:SetValueStep(0.05)
getglobal(opacity_slider:GetName() .. 'Low'):SetText('5%')
getglobal(opacity_slider:GetName() .. 'High'):SetText('100%')
getglobal(opacity_slider:GetName() .. 'Text'):SetText('Opacity')
opacity_slider:SetScript("OnValueChanged", function(self)
	local value = opacity_slider:GetValue()
	MAIN_FRAME:SetAlpha(value)
end)

local header = CreateFrame("Frame", "header", MAIN_FRAME)
header:SetPoint("TOP", MAIN_FRAME, "TOP", 0, 12)
header:SetWidth(256)
header:SetHeight(64)
header:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"
})

local drag = CreateFrame("Frame", nil, MAIN_FRAME)
drag:SetWidth(256)
drag:SetHeight(64)
drag:SetPoint("TOP", MAIN_FRAME, "TOP", 0, 12)
drag:EnableMouse(true)
drag:SetScript("OnMouseDown", function()
	MAIN_FRAME:StartMoving()
end)

drag:SetScript("OnMouseUp", function()
	MAIN_FRAME:StopMovingOrSizing()
end)

drag:SetScript("OnHide", function()
	MAIN_FRAME:StopMovingOrSizing()
end)

local title_Fontstring = header:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title_Fontstring:SetPoint("CENTER", header, "CENTER", 0, 12)
title_Fontstring:SetText("raidpos")

local buttonClose = CreateFrame("Button", "Close_button", MAIN_FRAME)
buttonClose:SetPoint("TOPRIGHT", MAIN_FRAME, "TOPRIGHT", -5, -5)
buttonClose:SetHeight(32)
buttonClose:SetWidth(32)
buttonClose:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
buttonClose:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
buttonClose:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
buttonClose:SetScript("OnLoad", 
	function()
		buttonClose:RegisterForClicks("AnyUp")
	end
)
buttonClose:SetScript("OnClick", 
	function()
		MAIN_FRAME:Hide();
	end
)
DOTS_COORD = {
	[1] = {-90, -70}, -- Healer     		--
	[2] = {0, 0}, -- safe spot melee  		 |
	[3] = {0, 0}, -- safe spot melee   		 |Group 1
	[4] = {0, 0}, -- safe spot melee  		 |
	[5] = {0, 0}, -- perma melee              --
	[6] = {-90, 95}, -- Healer     		    --
	[7] = {-75, 95}, -- safe spot melee   	 |
	[8] = {-105, 15}, -- safe spot melee   	 |Group 2
	[9] = {-75, -70}, -- safe spot melee 	     |
	[10] = {-55, 15}, -- perma melee          --
	[11] = {90, 95}, -- Healer     	     	--
	[12] = {10, 125}, -- safe spot melee   	 |
	[13] = {-55, 170}, -- safe spot melee  	 |Group 3
	[14] = {70, 170}, -- safe spot melee 		 |
	[15] = {-5, 55}, -- perma melee 		    --
	[16] = {90, -65}, -- Healer     		--
	[17] = {75, 95}, -- safe spot melee   	 |
	[18] = {105, 15}, -- safe spot melee   	 |Group 4
	[19] = {75, -65}, -- safe spot melee  	 |
	[20] = {55, 10}, -- perma melee  			--
	[21] = {-0, -100}, -- Healer     		--
	[22] = {65, -150}, -- healer/ranged   	 |
	[23] = {-65, -150}, -- ranged   		 |Group 5
	[24] = {90, -210}, -- ranged  			 |
	[25] = {-90, -210}, -- ranged  			--
	[26] = {-120, 15}, -- Healer     		--
	[27] = {-160, -55}, -- Healer/ranged  	 |
	[28] = {-160, 80}, -- ranged  			 |Group 6
	[29] = {-220, -75}, -- ranged   		 |
	[30] = {-220, 105}, -- ranged  			--
	[31] = {-5, 125}, -- Healer        		--
	[32] = {-70, 170}, -- healer/ranged    	 |
	[33] = {55, 170}, -- ranged    			 |Group 7
	[34] = {-90, 230}, -- ranged     		 |
	[35] = {90, 230}, -- ranged    			--
	[36] = {120, 15}, -- Healer      		--
	[37] = {160, 80}, -- healer/ranged    	 |
	[38] = {160, -55}, -- ranged    		 |Group 8
	[39] = {220, 105}, -- ranged   			 |
	[40] = {225, -85}, -- ranged  			--
	[41] = {-165, 175}, -- hunter          --
	[42] = {165, 175}, -- hunter            |
	[43] = {170, -160}, -- hunter           |  Hunters
	[44] = {-170, -160}, -- hunter          |
	[45] = {-235, 15}, -- hunter            |
	[46] = {0, 235}, -- hunter              |
	[47] = {235, 15}, -- hunter             |
	[48] = {0, -220}-- hunter              --
}

function createDotFrames()
	--Create dot frames
	for i, dot_coord in ipairs(DOTS_COORD) do
		dot = CreateFrame("Button", "Dot_"..i, MAIN_FRAME)
		dot:SetPoint("CENTER", MAIN_FRAME, "CENTER", dot_coord[1], dot_coord[2])
		dot:EnableMouse(true)
		dot:SetFrameLevel(dot:GetFrameLevel()+3)
		tooltip = CreateFrame("GameTooltip", "Tooltip_"..i, nil, "GameTooltipTemplate")
		local texdot = dot:CreateTexture("Texture_"..i, "OVERLAY")
		dot.texture = texdot
		texdot:SetAllPoints(dot)
		texdot:SetTexture("Interface\\AddOns\\RaidPos\\Images\\playerdot.tga")
		texdot:Hide()
		dot:SetScript("OnEnter", function()
			tooltip:SetOwner(dot, "ANCHOR_RIGHT")
			tooltip:SetText("Empty")
			tooltip:Show()
		end)
		dot:SetScript("OnLeave", function()
			tooltip:Hide()
		end)
	end
end
createDotFrames()


function place(players)
	grid = fillGroups(players)
	createDots(grid)
	addHunters(players)
end

function clearMap()
	clearDots();
end

local function HandleSlashCommands(str)
	if (str == "help") then
		print("|cffffff00Commands:");
		print("|cffffff00   /kt |cff00d2d6help |r|cffffff00-- show this help menu");
		print("|cffffff00   /kt -- open Kel'Thuzad map");
		print("|cffffff00   /kt simu -- open map for simulation");
		print("|cffffff00   /kt clear -- clear positions");

	elseif (str == "" or str == nil) then
		MAIN_FRAME:Show();
		clearDots();
		players = getplayerList()
		players = Translate(players)
		place(players)
	elseif (str == "simu") then
		clearDots();
		MAIN_FRAME:Show();
		players = getplayerList("simu")
		place(players)
	elseif (str == "clear" ) then
		clearMap()
	else
		print("|cffffff00Command not found");
	end
end

function getplayerList(simu) 
	local players = {}
 	if simu == "simu" then
		-- {player, class, group}
		players = PlayersSimu
	else
		for i=1,40  do
			local name,_,group,_,class = GetRaidRosterInfo(i);
			players[i] = {name, class, group}
		end
	end
	return players
end

SLASH_RAIDPOS1 = "/kt";
SlashCmdList.RAIDPOS = HandleSlashCommands;
