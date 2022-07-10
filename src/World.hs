module World where

import Data.Vec as V
import Object (Object, accelerateObj, updateObjPos)
import Prelude as P

newtype World = World
  { objs :: [Object]
  }
  deriving (Show)

applyForce :: World -> Vec2F -> World
applyForce world force = World $ P.map (`accelerateObj` force) $ objs world

updateWorld :: World -> Float -> World
updateWorld world dt = World $ P.map (`updateObjPos` dt) $ objs world
