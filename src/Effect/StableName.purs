module Effect.StableName (StableName, makeStableName, eqStableName, hashStableName) where

import Prelude (class Eq)
import Effect (Effect)
import Data.Hashable (class Hashable)

{-|
  An abstract name for an object, that supports equality and hashing.

  Stable names have the following property:

  * If @sn1 :: StableName@ and @sn2 :: StableName@ and @sn1 == sn2@
   then @sn1@ and @sn2@ were created by calls to @makeStableName@ on
   the same object.

  The reverse is not necessarily true: if two stable names are not
  equal, then the objects they name may still be equal.  Note in particular
  that `makeStableName` may return a different `StableName` after an
  object is evaluated.
-}
foreign import data StableName :: Type -> Type

-- | Makes a 'StableName' for an arbitrary object.
foreign import makeStableName :: forall a. a -> Effect (StableName a)

-- | Equality on 'StableName' that does not require that the types of
-- the arguments match.
foreign import eqStableName :: forall a b. StableName a -> StableName b -> Boolean

-- | Convert a 'StableName' to an 'Int'.  The 'Int' returned is not
-- necessarily unique; several 'StableName's may map to the same 'Int'
-- (in practice however, the chances of this are small, so the result
-- of 'hashStableName' makes a good hash key).
foreign import hashStableName :: forall a. StableName a -> Int

instance stableNameEq :: Eq (StableName a) where
  eq a b = eqStableName a b

instance stableNameHashable :: Hashable (StableName a) where
  hash a = hashStableName a