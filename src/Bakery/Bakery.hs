module Bakery.Bakery where
import           Control.Monad.Reader

-- |Baked type
newtype Baked p r = Baked {
  performBaked :: ReaderT p IO r
}


