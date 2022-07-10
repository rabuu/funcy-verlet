module Main where

import Graphics.Gloss

window :: Display
window = InWindow "Funcy Verlet" (200, 200) (10, 10)

background :: Color
background = white

fps :: Int
fps = 60

drawing :: Picture
drawing = circleSolid 80

main = putStrLn "Hello, World!"
