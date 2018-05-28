--[[
    Bird Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The Bird is what we control in the game via clicking or the space bar; whenever we press either,
    the bird will flap and go up a little bit, where it will then be affected by gravity. If the bird hits
    the ground or a pipe, the game is over.
]]

Bird = Class{}

local GRAVITY = 20

function Bird:init()
    self.image = love.graphics.newImage('images/bird.png')
    self.x = VIRTUAL_WIDTH / 2 - 8
    self.y = VIRTUAL_HEIGHT / 2 - 8

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.dy = 0
end

--[[
    AABB collision that expects a pipe, which will have an X and Y and reference
    global pipe width and height values.
]]
function Bird:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    local left_and_top_offset = 2
    local right_and_bot_offset = 4 
    if (self.x + left_and_top_offset) + (self.width - right_and_bot_offset) >= pipe.x and self.x + left_and_top_offset <= pipe.x + PIPE_WIDTH then
        if (self.y + left_and_top_offset) + (self.height - right_and_bot_offset) >= pipe.y and self.y + left_and_top_offset <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    local jump_height = -5

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        self.dy = jump_height 
        sounds['jump']:play()
    end

    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
