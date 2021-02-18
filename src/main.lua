local w, h = love.graphics.getDimensions()
local font = love.graphics.newFont(24)
love.graphics.setFont(font)
love.graphics.setDefaultFilter("linear", "nearest", 1)

local current_location = "Earth"
local horizontal_scroll = 0

local locations = require("locations")

local assets = {
  rocket = { vertical_offset = 0, scale = 1/2 }, -- temporary?
  vab = { vertical_offset = -15, scale = 4 },
  space = { vertical_offset = 0, scale = 1 },
}
for name, asset in pairs(assets) do
  asset.image = love.graphics.newImage("img/"..name..".png")
  asset.half_width = asset.image:getWidth() / 2
  asset.half_height = asset.image:getHeight() / 2
end

local structures = {
  {
    type = "vab",
    horizontal_position = 350,
    location = "Earth"
  },
}

local vehicles = {
  {
    type = "rocket",
    x = 0, y = 0,
    location = "Earth"
  },
  {
    type = "rocket",
    x = 100, y = 0,
    location = "Earth"
  },
}

function love.update(dt)
  require("lib.lovebird").update()

  -- horizontal scroll
  if love.keyboard.isDown("left") then
    horizontal_scroll = horizontal_scroll + dt * 800
  elseif love.keyboard.isDown("right") then
    horizontal_scroll = horizontal_scroll - dt * 800
  end
end

function love.draw()
  local location = locations[current_location]
  local parent = locations[location.parent]

  -- background
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.draw(assets.space.image, math.max(-1088, -location.distance*20 - parent.distance*20), 0)

  -- ground
  if location.ground_color then
    if location.parent ~= "Sun" then
      love.graphics.setColor(parent.orbital_color)
      love.graphics.circle("fill", w/3, h/6, parent.orbital_size - location.distance*20)
    end
    if location.atmosphere_color then
      love.graphics.setColor(location.atmosphere_color)
      love.graphics.rectangle("fill", 0, 0, w, 2*h/3)
    end
    love.graphics.setColor(location.ground_color)
    love.graphics.rectangle("fill", 0, 2*h/3, w, h/3)
  else
    love.graphics.setColor(location.orbital_color)
    love.graphics.circle("fill", 0, h/2, location.orbital_size)
  end

  -- location label
  local text_width = font:getWidth(current_location)
  local text_height = font:getHeight()
  local text_start = math.floor(w/2 - text_width/2)
  love.graphics.setColor(0, 0, 0, 0.75)
  love.graphics.rectangle("fill", text_start, h - text_height, text_width, text_height)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(current_location, text_start, h - text_height)

  -- structures
  for _, structure in ipairs(structures) do
    if structure.location == current_location then
      local asset = assets[structure.type]
      love.graphics.draw(asset.image, w/4 + horizontal_scroll + structure.horizontal_position, 2*h/3 + asset.vertical_offset, 0, asset.scale, asset.scale, asset.half_width, asset.half_height)
    end
  end

  -- vehicles
  for _, vehicle in ipairs(vehicles) do
    if vehicle.location == current_location then
      local asset = assets[vehicle.type]
      love.graphics.draw(asset.image, w/4 + horizontal_scroll + vehicle.x, 2*h/3 + vehicle.y, 0, asset.scale, asset.scale, asset.half_width, asset.half_height)
    end
  end
end

function love.keypressed(key)
  -- switching location
  if key == "return" then
    current_location = next(locations, current_location)
    if not current_location then current_location = next(locations) end
    horizontal_scroll = 0
  end
  if key == "escape" then
    love.event.quit()
  end
end
