module Object where

import Data.Vec as V hiding (translate)
import Graphics.Gloss (Picture (Circle), circleSolid, color, red, translate)

data Object = Object
  { pos :: Vec2F,
    old_pos :: Vec2F,
    acc :: Vec2F
  }
  deriving (Show)

updateObjPos :: Float -> Object -> Object
updateObjPos dt obj =
  Object
    { pos = pos',
      old_pos = old_pos',
      acc = 0
    }
  where
    vel = pos obj - old_pos obj
    dtVec = Vec2F dt dt
    pos' = pos obj + vel + acc obj * dtVec * dtVec
    old_pos' = pos obj

accelerateObj :: Object -> Vec2F -> Object
accelerateObj obj accAdd = obj {acc = acc'} where acc' = acc obj + accAdd

renderObj :: Object -> Picture
renderObj obj = translate x y $ color col $ circleSolid 30
  where
    x = V.head $ unpack $ pos obj
    y = V.last $ unpack $ pos obj
    col = red
