-- french class translation here // todo get client language and proper translate function
function translate(players)
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

-- local locale = GetLocale()
-- Localized class names.  Index == enUS, value == localized
-- local classnames = locale == "deDE" and {
-- 	["Warlock"] = "Hexenmeister",
-- 	["Warrior"] = "Krieger",
-- 	["Hunter"] = "Jäger",
-- 	["Mage"] = "Magier",
-- 	["Priest"] = "Priester",
-- 	["Druid"] = "Druide",
-- 	["Paladin"] = "Paladin",
-- 	["Shaman"] = "Schamane",
-- 	["Rogue"] = "Schurke",
-- } or locale == "frFR" and {
-- 	["Warlock"] = "D\195\169moniste",
-- 	["Warrior"] = "Guerrier",
-- 	["Hunter"] = "Chasseur",
-- 	["Mage"] = "Mage",
-- 	["Priest"] = "Pr\195\170tre",
-- 	["Druid"] = "Druide",
-- 	["Paladin"] = "Paladin",
-- 	["Shaman"] = "Chaman",
-- 	["Rogue"] = "Voleur",
-- } or {
-- 	["Warlock"] = "Warlock",
-- 	["Warrior"] = "Warrior",
-- 	["Hunter"] = "Hunter",
-- 	["Mage"] = "Mage",
-- 	["Priest"] = "Priest",
-- 	["Druid"] = "Druid",
-- 	["Paladin"] = "Paladin",
-- 	["Shaman"] = "Shaman",
-- 	["Rogue"] = "Rogue",
-- }