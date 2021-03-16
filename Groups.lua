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

-- group 1, we want to display only 1 paladin, not the mt ot, or hunters
function fillGroup1(group, player)
	local name = player[1]
	local class = player[2]

	if (class == "Paladin") then
		group[1] = {name, class}
	end
end

 -- group 2 to 4 (1 Priest + CAC + 1 rogue per group (kick)
function fillMeleeGroups(group, player)
	local name = player[1]
	local class = player[2]

	if (isHealer(class)) then
		group[1] = {name, class}
	elseif (class == "Rogue") then
		if isEmptySpot(group[5]) then
			group[5] = {name, class}
		elseif isEmptySpot(group[2]) then
			group[2] = {name, class}
		elseif isEmptySpot(group[3]) then
			group[3] = {name, class}
		elseif isEmptySpot(group[4])  then
			group[4] = {name, class}
		else
			group[1] = {name, class}
		end
	elseif (class == "Warrior" or class == "Druid") then
		if isEmptySpot(group[4]) then
			group[4] = {name, class}
		elseif isEmptySpot(group[3]) then
			group[3] = {name, class}
		elseif isEmptySpot(group[2]) then
			group[2] = {name, class}
		elseif isEmptySpot(group[5]) then
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