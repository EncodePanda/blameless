module Main (main) where

import Blameless.Effects.Console
import Blameless.Effects.FileSystem
import Blameless.Effects.Git
import Blameless.Program (ProgramErr, program)
import Data.Either.Combinators (whenLeft)
import Data.Function ((&))
import Effectful
import Effectful.Error.Dynamic (runError)
import System.Exit (exitFailure)

main :: IO ()
main = do
  resErr <-
    program
      & runGit
      & runFileSystem
      & runConsole
      & runError @ProgramErr
      & runEff

  whenLeft resErr $ const exitFailure
