module Bakery.GLCommon
  ( module Graphics.Rendering.OpenGL
  , withBound
  ) where

import           Control.Exception
import           Graphics.Rendering.OpenGL

withBound :: StateVar (Maybe a) -> a -> IO c -> IO c
withBound bindVar name = bracket_ (bindVar $= Just name) (bindVar $= Nothing)
