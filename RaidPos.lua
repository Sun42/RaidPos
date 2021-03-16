local dotPos = {
	[1] = {-90, -70}, -- Healer     		--
	[2] = {0, 0}, -- safe spot cac  		 |
	[3] = {0, 0}, -- safe spot cac   		 |Group 1
	[4] = {0, 0}, -- safe spot cac  		 |
	[5] = {0, 0}, -- perma cac              -- (rogue kicker)
	[6] = {-90, 95}, -- Healer     		    --
	[7] = {-75, 95}, -- safe spot cac   	 |
	[8] = {-105, 15}, -- safe spot cac   	 |Group 2
	[9] = {-75, -70}, -- safe spot cac 	     |
	[10] = {-55, 15}, -- perma cac          -- (rogue kicker)
	[11] = {90, 95}, -- Healer     	     	--
	[12] = {10, 125}, -- safe spot cac   	 |
	[13] = {-55, 170}, -- safe spot cac  	 |Group 3
	[14] = {70, 170}, -- safe spot cac 		 |
	[15] = {-5, 55}, -- perma cac 		    -- (rogue kicker)
	[16] = {90, -65}, -- Healer     		--
	[17] = {75, 95}, -- safe spot cac   	 |
	[18] = {105, 15}, -- safe spot cac   	 |Group 4
	[19] = {75, -65}, -- safe spot cac  	 |
	[20] = {55, 10}, -- perma cac  			-- (rogue kicker)
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
	[41] = {-165, 175}, -- extra hunt  		--
	[42] = {165, 175}, -- extra hunt         |
	[43] = {170, -160}, -- extra hunt   	 |  Extra Hunters from group 1 to 4
	[44] = {-170, -160}, -- extra hunt   	 |
	[45] = {-235, 15}, -- extra hunt         |
	[46] = {0, 235}, -- extra hunt           |
	[47] = {235, 15}, -- extra hunt          |
	[48] = {0, -220}-- extra hunt           --
}

local classColors = {
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

local current_playername,_ = UnitName("player")
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
	-- fillGrid()
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

local buttonReveal = CreateFrame("Button", "Reveal_button", MAIN_FRAME)
buttonReveal:SetPoint("TOPLEFT", MAIN_FRAME, "TOPLEFT", 10, -10)
buttonReveal:SetHeight(32)
buttonReveal:SetWidth(64)
buttonReveal:SetText("Show");
buttonReveal:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
buttonReveal:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
buttonReveal:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")
buttonReveal:SetScript("OnLoad", 
	function()
		buttonReveal:RegisterForClicks("AnyUp")
	end
)
buttonReveal:SetScript("OnClick", 
	function()
		showDots()
	end

)
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

--Create dot frames
for i=1,48 do
	dot = CreateFrame("Button", "Dot_"..i, MAIN_FRAME)
	dot:SetPoint("CENTER", MAIN_FRAME, "CENTER", dotPos[i][1], dotPos[i][2])
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

function showDots()
	local tt = _G["Tooltip_42"]
	tt:Raise()
	tt:Show()
	-- tooltip:Show()
		-- for index, value in ipairs(childrn) do
	-- 	 if index == 1 then
	-- 		print(index)
	-- 	 end
	-- end--  _G["Tooltip_"..x],
end

function newDot(dot, tooltip, texture, name, class)
	if (current_playername == name) then
		dot:SetWidth(36)
		dot:SetHeight(36)
	else
		dot:SetWidth(20)
		dot:SetHeight(20)
	end
	
	if name == "Empty" or name == "" or name == nil then
		texture:Hide()
	else
		texture:SetVertexColor(classColors[class][1], classColors[class][2], classColors[class][3], 1.0)
		texture:Show()
	end

	dot:SetScript("OnEnter", function()
		tooltip:SetOwner(dot, "ANCHOR_RIGHT")
		tooltip:SetText(name)
		tooltip:Show()
	end)

	dot:SetScript("OnLeave", function()
		tooltip:Hide()
	end)
end

function createDots(grid)
	-- create paladin dot group 1 (dot, tooltip, texture, name, class)
	local x = ((1-1)*5)+1
	newDot(_G["Dot_"..x], _G["Tooltip_"..x], _G["Texture_"..x], grid[1][1][1], grid[1][1][2])
	
	-- create dots group 2 to 8
	for i=2,8 do
		for j=1,5 do
			local player = grid[i][j]
			local class = (player[2])
			local name = player[1]
			local x = ((i-1)*5)+j
			newDot(_G["Dot_"..x], _G["Tooltip_"..x], _G["Texture_"..x], name, class)
		end
	end
end

-- up to 8 hunters
function addExtraHunters(players)
	local cpt_hunter = 0
	for i, player in ipairs(players) do
		local name = player[1]
		local class = player[2]
		if class == "Hunter" then
			cpt_hunter = cpt_hunter + 1
			newDot(_G["Dot_4"..cpt_hunter],  _G["Tooltip_4"..cpt_hunter],  _G["Texture_4"..cpt_hunter], name, class)
		end
	end
end


function place(players)
	players = translate(players)
	grid = fillGroups(players)
	createDots(grid)
	addExtraHunters(players)
end


local function HandleSlashCommands(str)
	if (str == "help") then
		print("|cffffff00Commands:");
		print("|cffffff00   /kt |cff00d2d6help |r|cffffff00-- show this help menu");
		print("|cffffff00   /kt -- open Kel'Thuzad map");

	elseif (str == "" or str == nil) then
		MAIN_FRAME:Show();
		players = getplayerList()
		place(players)


	elseif (str == "simu") then
		MAIN_FRAME:Show();
		players = getplayerList("simu")
		place(players)
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
