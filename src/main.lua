local w, h = love.graphics.getDimensions()
local horizontal_scroll = 0
local location = "earth"

local assets = {
  rocket = { image = love.graphics.newImage("img/rocket.png") }
}
for _, asset in pairs(assets) do
  asset.half_width = asset.image:getWidth() / 2
  asset.half_height = asset.image:getHeight() / 2
end

local structures = {
  {
    type = "rocket",
    x = 0, y = 0,
    location = "earth"
  }
}

function love.update(dt)
  require("lovebird").update()

  -- horizontal scroll
  if love.keyboard.isDown("left") then
    horizontal_scroll = horizontal_scroll - dt * 800
  elseif love.keyboard.isDown("right") then
    horizontal_scroll = horizontal_scroll + dt * 800
  end
end

function love.draw()
  -- ground
  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.rectangle("fill", 0, 2*h/3, w, h)

  -- rocket
  love.graphics.setColor(1, 1, 1, 1)
  for _, structure in ipairs(structures) do
    if structure.location == location then
      local asset = assets[structure.type]
      love.graphics.draw(asset.image, w/4 + horizontal_scroll + structure.x, 2*h/3 + structure.y, 0, 1/2, 1/2, asset.half_width, asset.half_height)
    end
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
