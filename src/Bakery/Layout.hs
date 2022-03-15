module Bakery.Layout where
import           Bakery.Bakery
import           Control.Monad.Reader
import           Graphics.Rendering.OpenGL

data Reg2 = Reg2
  { begin :: Vector2 Int
  , end   :: Vector2 Int
  }

data Fit2 = Fit2
  { minFit :: Vector2 Int
  , maxFit :: Vector2 Int
  }

-- |Layout, for list of elements
newtype Layout = Layout ([Fit2] -> Reg2 -> [Reg2])

-- |Lays the elements using Layout
layWith
  :: (Monoid c, To Fit2 c, To Reg2 p, Monoid r)
  => Layout
  -> [Baked c p r]
  -> Baked c p r
layWith (Layout lay) subs = Baked
  { bakeChar     = foldMap bakeChar subs
  , performBaked = mconcat <$> do
                     reg <- asks toT
                     let regs = lay (toT . bakeChar <$> subs) reg
                     zipWithM (\r -> local (modifyT r) . performBaked) regs subs
  }
