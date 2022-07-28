module Main where

import Graphics.Gloss
import World

window :: Display
window = InWindow "Funcy Verlet" (width, height) (10, 10)

background :: Color
background = white

fps :: Int
fps = 60

main :: IO ()
main = play window background fps initialWorld renderWorld (const id) updateWorld
