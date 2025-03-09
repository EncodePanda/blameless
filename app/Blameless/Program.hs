module Blameless.Program (program) where

import Blameless.Effects.Console
import Blameless.Effects.Git
import Control.Monad (unless)
import Effectful

program :: (Git :> es, Console :> es) => Eff es ()
program = do
  -- Check if running in a Git repository
  repo <- isGitRepo
  unless repo $ logError "Not in a Git repository"
  pure ()
