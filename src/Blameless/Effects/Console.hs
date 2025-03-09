module Blameless.Effects.Console
  ( Console
  , logError
  , runConsole
  ) where

import Effectful
import Effectful.Dispatch.Dynamic

data Console :: Effect where
  LogError :: String -> Console m ()

type instance DispatchOf Console = Dynamic

logError :: Console :> es => String -> Eff es ()
logError = send . LogError

--------------------------------------------------------------------------------

runConsole :: IOE :> es => Eff (Console ': es) a -> Eff es a
runConsole = interpret $ \_ -> \case
  LogError msg -> liftIO $ putStrLn $ "Error: " ++ msg
