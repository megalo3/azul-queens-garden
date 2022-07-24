scoreBoard = nil
rotation = 0;

function onLoad()
    scoreBoard = getObjectFromGUID('566263')
    scoreBoard.setRotation({0, 270.00, 0});

    self.createButton({
        click_function = "flipScoreboard",
        function_owner = self,
        label          = "Switch Score Board",
        position       = {0,0,0},
        rotation       = {0,180,0},
        width          = 1300,
        height         = 250,
        font_size      = 150,
        color          = {0, 0, 0},
        font_color     = {.5, .5, 1}
    })
end

function flipScoreboard()
    if (rotation == 0) then
        rotation = 180
    else
        rotation = 0
    end
    scoreBoard.setRotation({0, 270, rotation})
end