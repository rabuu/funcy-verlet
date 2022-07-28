module World where

import Data.Vec as V hiding (translate)
import Graphics.Gloss
import Object
import Prelude as P

width :: Int
width = 1920

height :: Int
height = 1080

newtype World = World
  { objs :: [Object]
  }
  deriving (Show)

applyForce :: World -> Vec2F -> World
applyForce world force = World $ P.map (`accelerateObj` force) $ objs world

constraintPos :: Vec2F
constraintPos = Vec2F 0 0

constraintRadius :: Float
constraintRadius = 400

applyConstraintToObj :: Object -> Vec2F -> Float -> Object
applyConstraintToObj obj consPos radius = if dist > (radius - objRadius) then obj {pos = pos'} else obj
  where
    toObj = pos obj - consPos
    dist = sqrt $ fold (+) $ V.map (\x -> x * x) $ unpack toObj
    n = pack $ V.map (\x -> x / dist) $ unpack toObj
    pos' = consPos + (pack $ V.map (\x -> x * (dist - objRadius)) $ unpack n)

applyConstraintToWorld :: World -> Vec2F -> Float -> World
applyConstraintToWorld world consPos radius = World $ P.map (\o -> applyConstraintToObj o consPos radius) $ objs world

renderConstraint :: Picture
renderConstraint = translate x y $ color col $ circleSolid constraintRadius
  where
    x = V.head $ unpack constraintPos
    y = V.last $ unpack constraintPos
    col = black

updateWorld :: Float -> World -> World
updateWorld dt world = World $ P.map (updateObjPos dt) $ objs world'
  where
    world'' = applyForce world (Vec2F 0 (-981))
    world' = applyConstraintToWorld world'' constraintPos constraintRadius

renderWorld :: World -> Picture
renderWorld world = pictures $ (renderConstraint : (P.map renderObj $ objs world))

initialWorld :: World
initialWorld = World [Object (Vec2F 300 0) (Vec2F 300 0) (Vec2F 0 0)]
