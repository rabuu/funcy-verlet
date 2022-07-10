module World where

import Data.Vec as V
import Graphics.Gloss (Picture, pictures)
import Object (Object (Object), accelerateObj, renderObj, updateObjPos)
import Prelude as P

newtype World = World
  { objs :: [Object]
  }
  deriving (Show)

applyForce :: World -> Vec2F -> World
applyForce world force = World $ P.map (`accelerateObj` force) $ objs world

updateWorld :: Float -> World -> World
updateWorld dt world = World $ P.map (updateObjPos dt) $ objs world'
  where
    world' = applyForce world (Vec2F 0 (-981))

renderWorld :: World -> Picture
renderWorld world = pictures $ P.map renderObj $ objs world

initialWorld :: World
initialWorld = World [Object (Vec2F 300 0) (Vec2F 300 0) (Vec2F 0 0)]
