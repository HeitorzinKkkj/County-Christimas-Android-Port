

local cam,distance

-- settings is Global!!!!!!!!!!!!!!!!!!!!!!!!!!!!
settings = {
    on = true, -- script status
    offset = 20, -- camera distance
    speed = 3 -- camera speed
}

function onUpdatePost(e)
    if getProperty("isCameraOnForcedPos") or not settings.on then return end

    distance={0,0}
    for i = 0, 3 do
        if getPropertyFromGroup(mustHitSection and "playerStrums" or "opponentStrums", i, "animation.curAnim.name") == "confirm" then
            local offDir = (i == 0 or i == 2) and -1 or 1
            local dir = (i == 0 or i == 3) and 1 or 2
            distance[dir] = settings.offset * offDir
        end
    end
    setProperty("camFollow.x", cam[1]+distance[1])
    setProperty("camFollow.y", cam[2]+distance[2])
    setProperty("cameraSpeed", settings.speed)
end

function onMoveCamera() cam = {getProperty("camFollow.x"),getProperty("camFollow.y")} end