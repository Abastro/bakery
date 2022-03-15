module Bakery.Bakery
  ( Baked(..)
  , To(..)
  ) where
import           Control.Monad.Reader

-- TODO bakeChar is suboptimal
-- |Represents baked matter
data Baked c p r = Baked
  { bakeChar     :: !c
  , performBaked :: ReaderT p IO r
  } deriving Functor

-- |Way to obtain certain type from a complex
class To t a | a -> t where
  modifyT :: t -> a -> a
  toT :: a -> t

-- Many stuffs require IO.. so how to compose baked?
-- Need composer & prebaked (declarative)
