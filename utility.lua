-- Check if a table contains a value 
function has_value(parameters)
    for index, value in ipairs(parameters.table) do
        if value == parameters.value then
            return true
        end
    end
    return false
end

-- Finds a deck or card in a zone
function find_pile(zone)
    if (zone == nil) then return end
    local objects = zone.getObjects()
    local num_decks = 0
    local deck = nil
    for index, object in ipairs(objects) do
        local type = object.type
        if ((string.find(type, 'Deck') or string.find(type, 'Card')) and not object.hasTag('upgrade board')) then
            num_decks = num_decks + 1
            deck = object
        end
    end
    if (num_decks==1) then
        return deck
    else
        return nil
    end
end

-- Gets the top card in a zone
function getTopCard(zone)
    local deckOrCard = find_pile(zone)
    if (string.find(deckOrCard.type, 'Deck')) then
        return deckOrCard.takeObject()
    end
    if (string.find(deckOrCard.type, 'Card')) then
        return deckOrCard
    end
end

-- Finds a token in a zone
function find_token(zone)
    if (zone == nil) then return end
    local objects = zone.getObjects()
    local token = nil
    for index, object in ipairs(objects) do
        local type = object.tag
        if (string.find(type, 'Tile')) then
            token = object
        end
    end
    return token
end

-- Lua doesn't have a round function!
function round(parameters)
    local mult = 10^(parameters.places or 0)
    return math.floor(parameters.number * mult + 0.5) / mult
end

function isPlayerColor(value)
    isColor = false
    for key, color in ipairs(Global.getVar('Colors')) do
        if (color == value) then isColor = true end
    end
    return isColor
end

function checkDestruct(obj)
    if (obj != nil) then
        obj.destruct()
    end
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

function getTurnOrderFromStartingPlayer(startColor)    
    local playerOrder = {}
    local currentOrderIndex = 1
    for c=1,7 do
        if (has_value({ table = getSeatedPlayers(), value = Turns.order[c]})) then
            table.insert(playerOrder, Turns.order[c])
        end
    end
    
    for index, value in ipairs(playerOrder) do
        if (startColor == value) then
            currentOrderIndex = index
        end
    end
    
    local turnOrderFromStarter = {}
    
    for c=currentOrderIndex, #getSeatedPlayers() do
        table.insert(turnOrderFromStarter, playerOrder[c])
    end
    for c=1,(currentOrderIndex-1) do
        table.insert(turnOrderFromStarter, playerOrder[c])
    end
    
    return turnOrderFromStarter
end