Colors = {'Red', 'Yellow', 'Green', 'Blue'}

resupplyInProgress = false

startPlayerCard = nil
tileBag = nil
gameLoaded = false

-- Round 1, 2, 3, 4, Supply
ExpansionLocations = {
    {-9.38, 1.06, 0.39},
    {15.70, 1.23, 4.51},
    {15.70, 1.23, 0.39},
    {15.71, 1.23, -3.79},
    {9.77, 1.24, 0.43}
}

DeployTileZone = 'dd6520'

function onLoad()
    math.randomseed(os.time())
    -- Set items uninteractable
    for key, object in ipairs(getObjectsWithTag('noninteractable')) do
        object.interactable = false
    end
    for key, object in ipairs(getObjectsWithTag('Joker')) do
        -- object.locked = false
    end
    
    startPlayerCard = getObjectFromGUID('f39ae8')
    tileBag = getObjectFromGUID('4fd8a3')
    tileBag.shuffle()
        
    if (startPlayerCard.hasTag('started')) then
        UI.hide('StartPanel')
    end
    gameLoaded = true
end

function onObjectEnterScriptingZone(zone, card)
    -- Only act if dropped in the rotate drop zone
    if (zone.guid != '7050f3' and zone.guid != '3ab246') then return end
    
    local rotation = card.getRotation()
    card.setRotationSmooth({0, rotation[2] + 60, 0}, true, true)
end

-- The game always starts on the Red player's turn. If there is no Red player,
-- the turn automatically switches to the next player. If a Red player exists,
-- onPlayerTurnEnd will not trigger.
function onPlayerTurnEnd(color)
   
end

function start()
    -- Give the starter card "Started" tag to know on load if this is loading a saved game
    startPlayerCard.addTag('started')
    
    if (not hasPlayerSelectedColors()) then
        print('At least two players must select a color before starting the game.')
        return
    end
    
    local playerCount = #getSeatedPlayers()
    
    if (playerCount < 2) then
        print('Azul Queen\'s Garden is 2 to 4 players.')
        return
    end
    
    -- 4+ player count
    local stackCount = 8;
    if (playerCount == 3) then stackCount = 7 end
    if (playerCount == 2) then stackCount = 5 end
    
    local expansionBag = getObjectFromGUID('8d465f')
    expansionBag.shuffle()

    for c=1,4 do
        for k=1,stackCount do
            expansionBag.takeObject({
                position = {x=ExpansionLocations[c][1], y=k+1, z=ExpansionLocations[c][3]},
                smooth = true,
                rotation = {180,0,0}
            })
        end
    end
    
    local leftoverCount = #expansionBag.getObjects()
    -- Move leftover garden expansions to spot 5
    for k=1,leftoverCount do
        expansionBag.takeObject({
            position = {x=ExpansionLocations[5][1], y=k+1, z=ExpansionLocations[5][3]},
            smooth = true,
            rotation = {180,0,0}
        })
    end
    getObjectFromGUID('7e2574').setPositionSmooth({
        ExpansionLocations[5][1], leftoverCount+2, ExpansionLocations[5][3]
    })
    
    UI.hide('StartPanel')
    gameStarted = true

end

function hasPlayerSelectedColors()
    hasPlayerColors = false;
    for key,value in ipairs(getSeatedPlayers()) do
        if (isPlayerColor(value)) then
            hasPlayerColors = true
        end
    end
    return hasPlayerColors
end

function isPlayerColor(value)
    isColor = false
    for key, color in ipairs(Global.getVar('Colors')) do
        if (color == value) then isColor = true end
    end
    return isColor
end