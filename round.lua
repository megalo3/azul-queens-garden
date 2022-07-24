NewRoundButtons = nil

function onLoad()
    NewRoundButtons = getObjectsWithTag('newroundbutton')

    for key, object in ipairs(NewRoundButtons) do
        object.createButton({
            click_function = "dealNewRound" .. key,
            function_owner = self,
            label          = object.getName(),
            position       = {0,0,0},
            rotation       = {0,180,0},
            width          = 1500,
            height         = 325,
            font_size      = 250,
            color          = {0, 0, 0},
            font_color     = {.19, .7, .17}
        })
    end

    
end

function dealNewRound1() dealNewRound(1) end
function dealNewRound2() dealNewRound(2) end
function dealNewRound3() dealNewRound(3) end

function dealNewRound(n)
    local zone = NewRoundButtons[n]
    local objects = zone.getObjects()
    local loc = Global.getVar('ExpansionLocations')[1]
    for index, object in ipairs(objects) do
        object.setPositionSmooth({loc[1], index+1, loc[3]})
    end
    zone.removeButton(0)
end