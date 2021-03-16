local locale = GetLocale()
-- Localized class names.  Index == enUS, value == localized
local classnames = locale == "deDE" and {
 	["Warlock"] = "Hexenmeister",
	["Warrior"] = "Krieger",
	["Hunter"] = "Jäger",
	["Mage"] = "Magier",
	["Priest"] = "Priester",
	["Druid"] = "Druide",
	["Paladin"] = "Paladin",
	["Shaman"] = "Schamane",
	["Rogue"] = "Schurke",
} or locale == "frFR" and {
	["Warlock"] = "D\195\169moniste",
	["Warrior"] = "Guerrier",
	["Hunter"] = "Chasseur",
	["Mage"] = "Mage",
	["Priest"] = "Pr\195\170tre",
	["Druid"] = "Druide",
	["Paladin"] = "Paladin",
	["Shaman"] = "Chaman",
	["Rogue"] = "Voleur",
} or {
	["Warlock"] = "Warlock",
	["Warrior"] = "Warrior",
	["Hunter"] = "Hunter",
	["Mage"] = "Mage",
	["Priest"] = "Priest",
	["Druid"] = "Druid",
	["Paladin"] = "Paladin",
	["Shaman"] = "Shaman",
	["Rogue"] = "Rogue",
}
local reverseclassnames = {}
for i,v in pairs(classnames) do
    reverseclassnames[v] = i
end

function Translate(players)
	for i, player in ipairs(players) do
		local classname = player[2]
 		player[2] = reverseclassnames[classname]
	end
 	return players
end
