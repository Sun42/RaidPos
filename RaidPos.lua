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

local frame = CreateFrame("Frame", "Kt_room", UIParent)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetHeight(534)
frame:SetWidth(534)
frame:SetPoint("CENTER", 0, 0)
frame:SetBackdrop(backdrop)
frame:SetAlpha(1.00)
frame:SetUserPlaced(true)
frame:SetFrameStrata("HIGH")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", function()
	-- fillGrid()
end)
frame:Hide()

local opacity_slider = CreateFrame("Slider", "MySlider1", frame, "OptionsSliderTemplate")
opacity_slider:SetPoint("BOTTOM", frame, "BOTTOMLEFT", 110, 20)
opacity_slider:SetMinMaxValues(0.05, 1.00)
opacity_slider:SetValue(1.00)
opacity_slider:SetValueStep(0.05)
getglobal(opacity_slider:GetName() .. 'Low'):SetText('5%')
getglobal(opacity_slider:GetName() .. 'High'):SetText('100%')
getglobal(opacity_slider:GetName() .. 'Text'):SetText('Opacity')
opacity_slider:SetScript("OnValueChanged", function(self)
	local value = opacity_slider:GetValue()
	frame:SetAlpha(value)
end)

local header = CreateFrame("Frame", "header", frame)
header:SetPoint("TOP", frame, "TOP", 0, 12)
header:SetWidth(256)
header:SetHeight(64)
header:SetBackdrop({
	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"
})

local drag = CreateFrame("Frame", nil, frame)
drag:SetWidth(256)
drag:SetHeight(64)
drag:SetPoint("TOP", frame, "TOP", 0, 12)
drag:EnableMouse(true)
drag:SetScript("OnMouseDown", function()
	frame:StartMoving()
end)

drag:SetScript("OnMouseUp", function()
	frame:StopMovingOrSizing()
end)

drag:SetScript("OnHide", function()
	frame:StopMovingOrSizing()
end)

local title_Fontstring = header:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
title_Fontstring:SetPoint("CENTER", header, "CENTER", 0, 12)
title_Fontstring:SetText("raidpos")

local button = CreateFrame("Button", "Close_button", frame)
button:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
button:SetHeight(32)
button:SetWidth(32)
button:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
button:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
button:SetScript("OnLoad", 
	function()
		button:RegisterForClicks("AnyUp")
	end 
)
button:SetScript("OnClick", 
	function()
		frame:Hide();
	end
)

--Create dot frames
for i=1,48 do
	dot = CreateFrame("Button", "Dot_"..i, frame)
	dot:SetPoint("CENTER", frame, "CENTER", dotPos[i][1], dotPos[i][2])
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

-- group 1, we want to display only 1 paladin, not the mt ot, or hunters
function fillGroup1(group, player)
	local name = player[1]
	local class = player[2]

	if (class == "Paladin") then
		group[1] = {name, class}
	end
end

 -- group 2 to 4 (1 Priest + CAC + 1 rogue per group (kick) + extra hunts max ranged)
function fillMeleeGroups(group, player)
	local name = player[1]
	local class = player[2]

	if (class == "Priest") then
		group[1] = {name, class}
	elseif (class == "Rogue") then
		if group[5][1] == "Empty" or group[1][1] == name then
			group[5] = {name, class}
		elseif group[2][1] == "Empty" or group[5][1] == name then
			group[2] = {name, class}
		elseif group[3][1] == "Empty" or group[2][1] == name then
			group[3] = {name, class}
		elseif group[4][1] == "Empty" or group[3][1] == name then
			group[4] = {name, class}
		else
			group[1] = {name, class}
		end
	elseif (class == "Warrior" or class == "Druid") then
		if group[4][1] == "Empty" or group[1][1] == name then
			group[4] = {name, class}
		elseif group[3][1] == "Empty" or group[5][1] == name then
			group[3] = {name, class}
		elseif group[2][1] == "Empty" or group[2][1] == name then
			group[2] = {name, class}
		elseif group[5][1] == "Empty" or group[3][1] == name then
			group[5] = {name, class}
		else
			group[1] = {name, class}
		end
	end
end

function isMaxRanged(class)
	if class == "Warlock" then
		return true
	end
	return false
end

function isHealer(class)
	if (class == "Paladin" or class == "Priest" or class == "Druid" or class == "Shaman") then
		return true
	end
	return false
end

function isMiddleRanged(class)
	if (class == "Mage") then
		return true
	end
	return false
end


function isEmptySpot(spot)
	if spot[1] == "Empty" then
		return true
	end
	return false
end

-- group 5 to 8
function fillRangedGroups(group, player)
	local name = player[1]
	local class = player[2]
	if (isHealer(class) or isMiddleRanged(class)) then
		if isEmptySpot(group[1]) then
			group[1] = {name, class}
		elseif isEmptySpot(group[2]) then
			group[2] = {name, class}
		elseif isEmptySpot(group[3]) then
			group[3] = {name, class}
		elseif isEmptySpot(group[4]) then
			group[4] = {name, class}
		else
			group[5] = {name, class}
		end
	elseif (isMaxRanged(class)) then
		if isEmptySpot(group[5]) then
			group[5] = {name, class}
		elseif isEmptySpot(group[4]) then
			group[4] = {name, class}
		elseif isEmptySpot(group[3]) then
			group[3] = {name, class}
		elseif isEmptySpot(group[2]) then
			group[2] = {name, class}
		else
			group[1] = {name, class}
		end
	end
end

function fillGroups(players)
	local grid = 
	{{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, -- group 1
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, -- group 2
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, --    |
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, --    |
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, --    |
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, --    |
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}, --    |
	{{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"},{"Empty","Empty"}}} -- group 8

	for i, player in ipairs(players) do
		local groupNum = player[3]

		if (groupNum == 1) then
			fillGroup1(grid[groupNum], player)
		elseif (groupNum >= 2 and groupNum <= 4) then
			fillMeleeGroups(grid[groupNum], player)
		elseif (groupNum >= 5) then
			fillRangedGroups(grid[groupNum], player)
		end
	end
	return grid
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




local function HandleSlashCommands(str)
	if (str == "help") then
		print("|cffffff00Commands:");
		print("|cffffff00   /kt |cff00d2d6help |r|cffffff00-- show this help menu");
		print("|cffffff00   /kt -- open Kel'Thuzad map");

	elseif (str == "" or str == nil) then
		frame:Show();
		players = getplayerList()
		players = translateFR(players)
		grid = fillGroups(players)
		createDots(grid)
		addExtraHunters(players)

	elseif (str == "simu") then
		frame:Show();
		players = getplayerList("simu")
		players = translateFR(players)
		grid = fillGroups(players)
		createDots(grid)
		addExtraHunters(players)
	else
		print("|cffffff00Command not found");
	end
end

-- french class translation here // todo get client language and proper translate function
function translateFR(players)
	for i, player in ipairs(players) do
		local class = player[2]
 		if class == "Chasseur" then
 			class = "Hunter"
 		elseif class ==  "Guerrier"	then
 			class = "Warrior"
 		elseif class == "Voleur" then
 			class = "Rogue"
 		elseif class == "Démoniste"  then
 			class = "Warlock"
 		elseif class == "Druide" then
 			class = "Druid"
 		elseif class == "Prêtre" then
 			class = "Priest"
 		end
 		player[2] = class
	end
 	return players
end

function getplayerList(simu) 
	local players = {}
 	if simu == "simu" then
		-- {player, class, group}
		players = {
		{"Darchman", "Paladin", 1}, {"Iron", "Warrior", 1}, {"Illyria", "Warrior", 1}, {"Micrurus", "Warrior", 1}, {"Crilind", "Druid", 1},
		{"BB", "Prêtre", 2}, {"bool", "Warrior", 2}, {"Kerdec", "Warrior", 2}, {"Helwing", "Rogue", 2}, {"Kryd", "Rogue", 2},
		{"Angenoires", "Priest", 3}, {"Jahmat", "Guerrier", 3}, {"Wacco", "Warrior", 3}, {"Stardust", "Rogue", 3}, {"Rog", "Rogue", 3},
		{"Geörgio", "Priest", 4}, {"Idys", "Warrior", 4}, {"Katy", "Chasseur", 4}, {"Pixii", "Voleur", 4}, {"Ashblade", "Rogue", 4},
		{"Rey", "Priest", 5}, {"Xemmnas", "Mage", 5}, {"Brënt", "Mage", 5}, {"Edea", "Mage", 5}, {"Sundas", "Hunter", 5},
		{"Damien", "Paladin", 6}, {"Kaarhan", "Mage", 6}, {"Gorfith", "Priest", 6}, {"kiljas", "Hunter", 6}, {"Mirumoto", "Hunter", 6},
		{"Lenala", "Priest", 7}, {"Spätzle", "Druide", 7}, {"Edea", "Mage", 7}, {"Néila", "Warlock", 7}, {"Alhanard", "Warlock", 7},
		{"Holy", "Paladin", 8}, {"Newton", "Mage", 8}, {"Makavely", "Warlock", 8}, {"Picotte", "Démoniste", 8},  {"jog", "Mage", 8}
		}
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
