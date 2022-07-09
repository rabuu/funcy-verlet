module Main where

import Graphics.Gloss

-- display a circle
main :: IO ()
main = display (InWindow "Funcy Verlet" (200, 200) (10, 10)) white (Circle 80)
