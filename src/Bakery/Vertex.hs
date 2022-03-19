module Bakery.Vertex where
import           Bakery.Bakery
import           Bakery.GLCommon
import           Foreign.Ptr

instance KnownData BufferTarget ArrayBuffer where dataOf = DataOf ArrayBuffer
instance KnownData BufferTarget UniformBuffer where dataOf = DataOf UniformBuffer

-- |Buffer data - TODO Pointer
data BufferData (t :: BufferTarget) = BufferData
  { bufUsage  :: BufferUsage
  , bufPtr :: Ptr Int
  }

-- |Corresponds to Buffer Object
newtype BakedBuffer = BakedBuffer BufferObject

instance KnownData BufferTarget t => Baking BakedBuffer (BufferData t) where
  bake dat = do
    let tar = dataVal dat
    buf <- genObjectName @BufferObject
    withBound (bindBuffer tar) buf $ do
      bufferData tar $= (1, error "Data Ptr", bufUsage dat)
    pure $ BakedBuffer buf

-- |Vertex description
data VertexData = VertexData {}

-- |Corresponds to Vertex Array Object
newtype BakedVertexArray = BakedVertexArray VertexArrayObject

instance Baking BakedVertexArray VertexData where
  bake dat = do
    arr <- genObjectName @VertexArrayObject
    withBound bindVertexArrayObject arr $ do
      undefined
    pure $ BakedVertexArray arr

