module Main (main) where

import Blameless.Effects.Console
import Blameless.Effects.FileSystem
import Blameless.Effects.Git
import Blameless.Program (program)
import Data.Function ((&))
import Effectful

main :: IO ()
main =
  program
    & runGit
    & runFileSystem
    & runConsole
    & runEff
