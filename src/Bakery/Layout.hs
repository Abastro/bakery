module Bakery.Layout where
import           Bakery.Bakery
import           Control.Monad.Reader
import           Graphics.Rendering.OpenGL
import           Optics

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

-- Perhaps Container here? Not very composable..

{-
layWith
  :: (Monoid c, Monoid r)`
  => Getter c Fit2
  -> Lens' p Reg2
  -> Layout
  -> [Baked c p r]
  -> Baked c p r
layWith ch ctx (Layout lay) subs = Baked
  { bakeChar     = foldMap bakeChar subs
  , performBaked = mconcat <$> do
                     reg <- asks (view ctx)
                     let regs = lay (view ch . bakeChar <$> subs) reg
                     zipWithM (\r -> local (set ctx r) . performBaked) regs subs
  }
-}
