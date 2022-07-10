module Main where

import Graphics.Gloss
import World

window :: Display
window = InWindow "Funcy Verlet" (600, 400) (10, 10)

background :: Color
background = white

fps :: Int
fps = 60

drawing :: Picture
drawing = circleSolid 80

main = play window background fps initialWorld renderWorld (const id) updateWorld
