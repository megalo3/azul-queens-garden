ScrollWheel = nil

function onLoad()
    ScrollWheel = getObjectFromGUID('371f9e')
    self.createButton({
        click_function = "turnWheel",
        function_owner = self,
        label          = "Rotate Wheel",
        position       = {0,0,0},
        rotation       = {0,180,0},
        width          = 1500,
        height         = 325,
        font_size      = 250,
        color          = {0, 0, 0},
        font_color     = {.7, .7, 1}
    })
end

function turnWheel()
    local yAxisRounds = {270, 0, 90, 180}
    local yRotation = ScrollWheel.getRotation()[2]
    if (yRotation >= 0 and yRotation < 90) then
        ScrollWheel.setRotationSmooth({0, 90 ,180})
    elseif (yRotation >= 90 and yRotation < 180) then
        ScrollWheel.setRotationSmooth({0, 180 ,180})
    elseif (yRotation >= 180 and yRotation < 270) then
        ScrollWheel.setRotationSmooth({0, 270 ,180})
    else
        ScrollWheel.setRotationSmooth({0, 0 ,180})
    end
end