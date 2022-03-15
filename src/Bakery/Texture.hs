module Bakery.Texture where
import           Bakery.Layout
import           Graphics.Rendering.OpenGL

makeTexture :: Int -> Int -> IO TextureObject
makeTexture w h = do
  tex <- genObjectName
  -- TODO Loading texture? Needs source!
  let pixData = PixelData RGBA Byte undefined
  textureBinding Texture2D $= Just tex
  texImage2D Texture2D NoProxy 0 RGBA8 (TextureSize2D (fromIntegral w) (fromIntegral h)) 0 pixData
  textureBinding Texture2D $= Nothing
  pure tex

-- Important: Texture require IO to build
