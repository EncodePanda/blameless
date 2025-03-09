module Blameless.Effects.FileSystem
  ( FileSystem
  , runFileSystem
  , dirExists
  ) where

import Effectful
import Effectful.Dispatch.Dynamic
import System.Directory (doesDirectoryExist)

data FileSystem :: Effect where
  DirExists :: FilePath -> FileSystem m Bool

type instance DispatchOf FileSystem = Dynamic

dirExists :: FileSystem :> es => FilePath -> Eff es Bool
dirExists = send . DirExists

--------------------------------------------------------------------------------

runFileSystem :: IOE :> es => Eff (FileSystem ': es) a -> Eff es a
runFileSystem = interpret $ \_ -> \case
  DirExists path -> liftIO $ doesDirectoryExist path
