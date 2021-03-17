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

function newDot(dot, tooltip, texture, name, class)
	if (CURRENT_PLAYERNAME == name) then
		dot:SetWidth(36)
		dot:SetHeight(36)
	else
		dot:SetWidth(20)
		dot:SetHeight(20)
	end

	if name == "Empty" or name == "" or name == nil then
		texture:Hide()
	else
		texture:SetVertexColor(CLASSCOLORS[class][1], CLASSCOLORS[class][2], CLASSCOLORS[class][3], 1.0)
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

function changeDot(dot, tooltip, texture)
    dot:SetWidth(40)
    dot:SetHeight(40)
    -- print(tooltip:GetText())
    dot:SetScript("OnLeave", function()
		-- tooltip:Hide()
	end)
    dot:SetScript("OnHide", function()
		tooltip:Hide()
	end)
end

-- up to 8 hunters
function addHunters(players)
	local cpt_hunter = 0
	for i, player in ipairs(players) do
		local name = player[1]
		local class = player[2]
		if (class == "Hunter" and cpt_hunter < 9) then
			cpt_hunter = cpt_hunter + 1
			newDot(_G["Dot_4"..cpt_hunter],  _G["Tooltip_4"..cpt_hunter],  _G["Texture_4"..cpt_hunter], name, class)
		end
	end
end


function clearDots()
    for i=1, 48 do
        newDot(_G["Dot_"..i],  _G["Tooltip_"..i],  _G["Texture_"..i], "Empty", "Empty")
    end
end

function changeDots()
    for i=1, 48 do
        changeDot(_G["Dot_"..i],  _G["Tooltip_"..i],  _G["Texture_"..i])
    end
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