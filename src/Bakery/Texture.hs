module Bakery.Texture
  ( TextureData(..)
  , BakedTexture
  ) where
import           Bakery.Bakery
import           Bakery.Layout
import           Control.Exception
import           Data.Int
import           Foreign.Ptr
import           Graphics.Rendering.OpenGL

-- Dough: Texture Spec
-- Baked: TextureObject

-- |2D Texture Data
data TextureData = TextureData
  { texWidth    :: Int
  , texHeight   :: Int
  -- |Format stored in texture
  , texelFormat :: PixelInternalFormat
  }
-- TODO: Add pixel transfer options

newtype BakedTexture = BakedTexture TextureObject

instance Baking BakedTexture TextureData where
  bake (TextureData w h tf) = do
    tex <- BakedTexture <$> genObjectName @TextureObject
    let pixData = undefined
    let texSize = TextureSize2D (fromIntegral w) (fromIntegral h)
    withTexture tex $ texImage2D Texture2D NoProxy 0 tf texSize 0 pixData
    pure tex

-- MAYBE Multiple textures
-- MAYBE Denote inner action should not do texturing

-- Perform rendering with texture
withTexture :: BakedTexture -> IO a -> IO a
withTexture (BakedTexture tex) act = do
  bracket_ (textureBinding Texture2D $= Just tex)
           (textureBinding Texture2D $= Nothing)
           act
