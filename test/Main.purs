module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Exception (throwException, error)

import Effect.StableName (makeStableName)

data Foo = Foo String
data Bar = Bar String

newtype Foo' = Foo' String
newtype Bar' = Bar' String

assert :: Boolean -> String -> Effect Unit
assert true _ = pure unit
assert _ desc = throwException (error desc)

main :: Effect Unit
main = do
  let foo = Foo  "foo"
  foo1 <- makeStableName $ foo
  foo2 <- makeStableName $ Foo  "foo"
  foo3 <- makeStableName $ Foo' "foo"
  foo4 <- makeStableName $ Foo' "foo"
  bar1 <- makeStableName $ Bar  "foo"
  bar2 <- makeStableName $ Bar' "foo"

  assert (foo1 == foo1) "equal refs to data"
  assert (foo1 /= foo2) "unequal refs to data"
  assert (foo3 == foo3) "newtypes"
  assert (foo3 == foo4) "newtypes"

  foo5 <- makeStableName $ foo
  assert (foo1 == foo5) "equal refs to data"