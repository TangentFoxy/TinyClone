local km_to_au = 6.68459e-9
local moon_grey = { 0.82, 0.84, 0.82, 1 }

local function greyish()
  color = {}
  for key, value in ipairs(moon_grey) do
    color[key] = value + (love.math.random() / 5 - 0.1)
  end
  color[4] = 1 -- fix alpha
  return color
end

local locations = {
  Sun = {
    parent = "Sun",
    distance = 0,
    orbital_color = { 1, 1, 0.8, 1 },
    orbital_size = 600,
    surface_area = 0,
    mass = 1.9885e30,
  },
  Earth = {
    parent = "Sun",
    distance = 1, -- in AU from parent
    orbital_color = { 0.1, 0.1, 2/3, 1 },
    orbital_size = 100,
    ground_color = { 0.2, 0.5, 0, 1 },
    atmosphere_color = { 0.53, 0.81, 0.92, 0.85 },
    surface_area = 1.4894e8,
    mass = 5.97237e24,
  },
  Moon = {
    parent = "Earth",
    distance = 0.00257,
    ground_color = moon_grey,
    surface_area = 3.793e7,
    mass = 7.342e22, -- in kg
  },
  Mercury = {
    parent = "Sun",
    distance = 0.387098,
    ground_color = { 219/255, 206/255, 202/255, 1 },
    surface_area = 7.48e7,
    mass =  3.3011e23,
  },
  Venus = {
    parent = "Sun",
    distance = 0.723332,
    ground_color = { 0.6, 0.4, 0, 1 },
    atmosphere_color = { 224/255, 196/255, 101/255, 0.95 },
    surface_area = 4.6023e8,
    mass = 4.8675e24,
  },
  Mars = {
    parent = "Sun",
    distance = 1.523679,
    orbital_color = { 190/255, 100/255, 80/255, 1 },
    orbital_size = 80,
    ground_color = { 181/255, 89/255, 69/255, 1 },
    atmosphere_color = { 1, 143/255, 143/255, 0.5 },
    surface_area = 1.447985e8,
    mass = 6.4171e23,
  },
  Phobos = {
    parent = "Mars",
    distance = 9376 * km_to_au,
    ground_color = { 156/255, 92/255, 92/255, 1 },
    surface_area = 1.5483e4,
    mass = 1.0659e16,
  },
  Deimos = {
    parent = "Mars",
    distance = 23463.2 * km_to_au,
    ground_color = { 219/255, 125/255, 125/255, 1 },
    surface_area = 495.1548,
    mass = 1.4762e15,
  },
  Ceres = {
    parent = "Sun",
    distance = 2.7691651545,
    ground_color = greyish(),
    surface_area = 2.77e6,
    mass = 9.3835e20,
  },
  Pallas = {
    parent = "Sun",
    distance = 2.773841434,
    ground_color = greyish(),
    surface_area = 8.3e5,
    mass = 2.04e20,
  },
  Jupiter = {
    parent = "Sun",
    distance = 5.2044,
    orbital_color = { 247/255, 224/255, 169/255, 1 },
    orbital_size = 160,
    atmosphere_color = {},
    surface_area = 0,
    mass = 1.8982e27,
  },
  -- Jupiter's moons would go here
  Saturn = {
    parent = "Sun",
    distance = 9.5826,
    orbital_color = { 234/255, 214/255, 184/255, 1 }, -- probably should be something else
    orbital_size = 120,
    atmosphere_color = {},
    surface_area = 0,
    mass = 5.6834e26,
  },
  Pandora = {
    parent = "Saturn",
    distance = 141720 * km_to_au,
    ground_color = greyish(),
    surface_area = 20816.04524,
    mass = 1.371e17,
  },
  Titan = {
    parent = "Saturn",
    distance = 1221870 * km_to_au,
    ground_color = { 0.77, 0.58, 0.35, 1 },
    atmosphere_color = { 0.8, 0.73, 0.38, 2/3 },
    surface_area = 83000000,
    mass = 1.3452e23,
  },
  Uranus = {
    parent = "Sun",
    distance = 19.2184,
    orbital_color = { 0.62, 0.78, 0.8, 1 },
    orbital_size = 80,
    atmosphere_color = {},
    surface_area = 0,
    mass = 8.681e25,
  },
  -- Uranus's moons go here
  Neptune = {
    parent = "Sun",
    distance = 30.07,
    orbital_color = { 0.41, 0.49, 0.68, 1 },
    orbital_size = 75,
    atmosphere_color = {},
    surface_area = 0,
    mass = 7.6183e9,
  },
  -- Neptune's moons
  Pluto = {
    parent = "Sun",
    distance = 39.482,
    orbital_color = { 0.9, 0.85, 0.8, 1 },
    orbital_size = 25,
    ground_color = { 0.86, 0.8, 0.73, 1 },
    surface_area = 1.779e7,
    mass = 1.303e22,
  },
  Charon = {
    parent = "Pluto",
    distance = 19591.4 * km_to_au,
    ground_color = { 0.51, 0.48, 0.46, 1 },
    surface_area = 4.6,
    mass = 1.586e21,
  },
  Makemake = {
    parent = "Sun",
    distance = 45.32,
    ground_color = greyish(),
    surface_area = 642000000,
    mass = 3.1e21,
  },
  Haumea = {
    parent = "Sun",
    distance = 43.182,
    ground_color = greyish(),
    surface_area = 814000000,
    mass = 4.006e21,
  },
  Eris = {
    parent = "Sun",
    distance = 67.864,
    ground_color = greyish(),
    surface_area = 17000000,
    mass = 1.6466e22,
  },
  -- Theoretical Planet Nine,Sun,600,4*math.pi*(6371*3)^2,7.5*5.97237e24,{ 0.4, 0.4, 0.9, 1 }
}

local file = love.filesystem.newFile("moons.csv", "r")

local field_names
for line in file:lines() do
  if not field_names then
    field_names = {}
    for match in line:gmatch("[^,]+") do
      field_names[#field_names + 1] = match
      -- print(#field_names, match)
    end
  else
    local i = 1
    local row = {}
    for match in line:gmatch("[^,]+") do
      -- print(i, match, field_names[i])
      if tonumber(match) then
        match = tonumber(match)
      end
      row[field_names[i]] = match
      i = i + 1
    end
    local ground_color
    if row.r == 0 and row.g == 0 and row.b == 0 and row.a == 0 then
      ground_color = greyish()
    else
      ground_color = { row.r, row.g, row.b, row.a }
    end
    locations[row.name] = {
      parent = row.parent,
      distance = row.distance * km_to_au,
      ground_color = ground_color,
      surface_area = row.surface_area,
      mass = row.mass,
    }
  end
end

return locations
