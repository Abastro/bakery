module Bakery.Bakery
  ( Baked(..)
  , Baking(..)
  , KnownData(..), DataOf(..), dataVal
  ) where
import           Control.Monad.Reader

-- TODO bakeChar is suboptimal
-- |Represents baked matter
data Baked c p r = Baked
  { bakeChar     :: !c
  , performBaked :: ReaderT p IO r
  }
  deriving Functor

class Baking b d | d -> b where
  bake :: d -> IO b


-- Staged stuffs (Get Properties -> Assign Space & Render)
-- Properties from branches, Render from root
-- Perhaps waste an IORef in baked..

newtype DataOf t (v :: t) = DataOf t
class KnownData t (v :: t) | v -> t where
  dataOf :: DataOf t v

dataVal :: KnownData t v => proxy v -> t
dataVal = go dataOf where
  go :: DataOf t v -> proxy v -> t
  go (DataOf v) _ = v
