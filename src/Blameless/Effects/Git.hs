module Blameless.Effects.Git
  ( Git
  , isGitRepo
  , runGit
  ) where

import Blameless.Effects.FileSystem
import Effectful
import Effectful.Dispatch.Dynamic

data Git :: Effect where
  IsGitRepo :: Git m Bool

type instance DispatchOf Git = Dynamic

isGitRepo :: Git :> es => Eff es Bool
isGitRepo = send IsGitRepo

--------------------------------------------------------------------------------

runGit :: FileSystem :> es => Eff (Git ': es) a -> Eff es a
runGit = interpret $ \_ -> \case
  IsGitRepo -> dirExists ".git"
