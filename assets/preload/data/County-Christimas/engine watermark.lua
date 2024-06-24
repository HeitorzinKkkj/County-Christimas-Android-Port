local prefs = {
    fakeForever = true
}

function onCreate()
    get = getProperty
    getFromClass = getPropertyFromClass
    getFromGroup = getPropertyFromGroup
    set = setProperty
    setFromClass = setPropertyFromClass
    setFromGroup = setPropertyFromGroup
end

function onCreatePost()
    makeLuaText("cornerMark", prefs.fakeForever and "FOREVER ENGINE 0.3.1" or "PSYCH ENGINE "..version, 0, 0, 5)
    setTextSize("cornerMark", 18)
    setTextBorder("cornerMark", 2, "000000")
    screenCenter("cornerMark", "X")
    setObjectCamera("cornerMark", "hud")
    set("cornerMark.antialiasing", getFromClass("ClientPrefs", "globalAntialiasing"))
    set("cornerMark.x", screenWidth - (get("cornerMark.width") + 5))
    addLuaText("cornerMark")
end
local scoreDivider = " • "

function math.roundDecimal(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function onCreate()
    get = getProperty
    getFromClass = getPropertyFromClass
    getFromGroup = getPropertyFromGroup
    set = setProperty
    setFromClass = setPropertyFromClass
    setFromGroup = setPropertyFromGroup

    string.startsWith = stringStartsWith
    string.endsWith = stringEndsWith
    string.split = stringSplit
end

function onCreatePost()
    set("scoreTxt.size", 18)
    set("scoreTxt.borderSize", 1.5)
    set("scoreTxt.antialiasing", getFromClass("ClientPrefs", "globalAntialiasing"))
end

function getRank()
    local rankShits = {
        {100, "S+"},
        {90, "S"},
        {80, "A"},
        {70, "B"},
        {60, "C"},
        {50, "D"},
        {40, "E"},
        {30, "F"},
        {0, "L"},
    }

    local retRank = "N/A"
    for i = 1, #rankShits do
        if rankShits[i][1] >= (get("ratingPercent") * 100) then
            retRank = rankShits[i][2]
        end
    end
    return retRank
end

function onUpdatePost(elapsed)
    local dumbRank = get("ratingName") == "?" and "N/A" or getRank()
    set("scoreTxt.text", "Score: "..get("songScore")..scoreDivider.."Accuracy: "..math.roundDecimal(get("ratingPercent") * 100, 2).."%"..scoreDivider.."Combo Breaks: "..get("songMisses")..scoreDivider.."Rank: "..dumbRank)
    scaleObject("scoreTxt", 1, 1)
end
function onCreate()
    get = getProperty
    getFromClass = getPropertyFromClass
    getFromGroup = getPropertyFromGroup
    set = setProperty
    setFromClass = setPropertyFromClass
    setFromGroup = setPropertyFromGroup
end

function onCreatePost()
    local hideList = {"timeBarBG", "timeBar", "timeTxt"}
    for i = 1, #hideList do
        set(hideList[i]..".visible", false)
    end

    makeLuaText("centerMark", "- "..songName.." ["..string.upper(difficultyName).."] -", 0, 0, (downscroll and screenHeight - 40 or 10))
    setTextSize("centerMark", 24)
    setTextBorder("centerMark", 2, "000000")
    screenCenter("centerMark", "X")
    setObjectCamera("centerMark", "hud")
    set("centerMark.antialiasing", getFromClass("ClientPrefs", "globalAntialiasing"))
    addLuaText("centerMark")

    set("botplayTxt.borderSize", 2)
    set("botplayTxt.y", (downscroll and (get("centerMark.y") - 60) - 125 or (get("centerMark.y") + 60) + 125))
    set("botplayTxt.antialiasing", getFromClass("ClientPrefs", "globalAntialiasing"))
    set("botplayTxt.text", "[AUTOPLAY]")
end