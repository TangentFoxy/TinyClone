local km_to_au = 6.68459e-9
local moon_grey = { 0.82, 0.84, 0.82, 1 }

local function greyish()
  color = {}
  for key, value in ipairs(moon_grey) do
    color[key] = value + (love.math.random() / 5 - 0.1)
  end
  return color
end

local locations = {
  Sun = {
    distance = 0,
    orbital_color = { 1, 1, 0.8, 1 },
    surface_area = 0,
    mass = 1.9885e30,
  },
  Earth = {
    parent = "Sun",
    distance = 1, -- in AU from parent
    ground_color = { 0.2, 0.5, 0, 1 },
    atmosphere_color = { 0.53, 0.81, 0.92, 1 },
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
    ground_color = { 219/255, 206/255, 202/255 },
    surface_area = 7.48e7,
    mass =  3.3011e23,
  },
  Venus = {
    parent = "Sun",
    distance = 0.723332,
    ground_color = { 0.6, 0.4, 0, 1 },
    atmosphere_color = { 224/255, 196/255, 101/255 },
    surface_area = 4.6023e8,
    mass = 4.8675e24,
  },
  Mars = {
    parent = "Sun",
    distance = 1.523679,
    ground_color = { 181/255, 89/255, 69/255 },
    atmosphere_color = { 1, 143/255, 143/255 },
    surface_area = 1.447985e8,
    mass = 6.4171e23,
  },
  Phobos = {
    parent = "Mars",
    distance = 9376 * km_to_au,
    ground_color = { 156/255, 92/255, 92/255 },
    surface_area = 1.5483e4,
    mass = 1.0659e16,
  },
  Deimos = {
    parent = "Mars",
    distance = 23463.2 * km_to_au,
    ground_color = { 219/255, 125/255, 125/255 },
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
}

return locations
