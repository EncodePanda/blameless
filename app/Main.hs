module Main (main) where

import Blameless.Program (program)
import Data.Function ((&))
import Effectful

main :: IO ()
main = program & runEff
