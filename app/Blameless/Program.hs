module Blameless.Program (program, ProgramErr) where

import Blameless.Effects.Console
import Blameless.Effects.Git
import Control.Monad (unless)
import Effectful
import Effectful.Error.Dynamic

data ProgramErr = DirNotGitRepository
  deriving stock Show

program :: (Git :> es, Console :> es, Error ProgramErr :> es) => Eff es ()
program = do
  -- Check if running in a Git repository
  repo <- isGitRepo
  unless repo $ do
    logError "Not in a Git repository"
    throwError DirNotGitRepository
  pure ()
