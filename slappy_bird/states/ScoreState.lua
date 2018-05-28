--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local GOLD_MEDAL_IMAGE = love.graphics.newImage('images/gold_medal.png')
local SILVER_MEDAL_IMAGE = love.graphics.newImage('images/silver_medal.png')
local BRONZE_MEDAL_IMAGE = love.graphics.newImage('images/bronze_medal.png')
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    if self.score >= 10 then 
        love.graphics.printf('You\'re amazing!', 0, 140, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(GOLD_MEDAL_IMAGE, VIRTUAL_WIDTH / 2 + 100,  VIRTUAL_HEIGHT /2 - 25)
    elseif self.score >= 5 then
        love.graphics.printf('You\'re pretty good!', 0, 140, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(SILVER_MEDAL_IMAGE, VIRTUAL_WIDTH / 2 + 100,  VIRTUAL_HEIGHT /2 - 40)
    elseif self.score >= 1 then
        love.graphics.printf('At least you tried.', 0, 140, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(BRONZE_MEDAL_IMAGE, VIRTUAL_WIDTH / 2 + 100,  VIRTUAL_HEIGHT / 2 - 40 )
    else
        love.graphics.printf('Better Luck Next Time !', 0, 140, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
