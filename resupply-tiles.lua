tileBag = nil
discardBag = nil
DeployLocs = {
    {-10.02, 2.27, 1.52},
    {-8.71, 2.27, 1.50},
    {-10.05, 2.27, -0.78},
    {-8.75, 2.27, -0.75}
}

function onLoad()
    tileBag = getObjectFromGUID('4fd8a3')
    discardBag = getObjectFromGUID('8babe8')
    discardBag2 = getObjectFromGUID('72fe1c')
    jokerBag = getObjectFromGUID('b1989a')
    gardenExpansionBag = getObjectFromGUID('8d465f')

    self.createButton({
        click_function = "resupplyTiles",
        function_owner = self,
        label          = "Deal Tiles",
        position       = {0,0,0},
        rotation       = {0,180,0},
        width          = 700,
        height         = 300,
        font_size      = 150,
        color          = {0, 0, 0},
        font_color     = {.5, .5, 1}
    })
end

function resupplyTiles()
    for c=1,4 do
        checkEmptyBagRussply()
        tileBag.takeObject({
            position = DeployLocs[c],
            rotation = {0,90,0}
        })
    end
end

function checkEmptyBagRussply()
    if (#tileBag.getObjects() == 0) then
        sortDiscards(discardBag)
        sortDiscards(discardBag2)
        tileBag.shuffle()
    end
end

function sortDiscards(bag)
    for index, card in ipairs(bag.getObjects()) do
        local takenObject = bag.takeObject()
        if (takenObject.hasTag('coloredtile')) then
            tileBag.putObject(takenObject)
        elseif (takenObject.hasTag('Joker')) then
            jokerBag.putObject(takenObject)
        elseif (takenObject.hasTag('gardenexpansion')) then
            gardenExpansionBag.putObject(takenObject)
        else
            takenObject.setPositionSmooth({26.68, 4.25, -11.08})
        end
    end
end