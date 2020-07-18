module WithAnyBar.App where
import WithAnyBar.Types
import Utils.AnyBar (maybeFindAnyBar)
import Utils.Shell (openApp)
import Control.Monad.IO.Class (liftIO)

locateAnyBar :: App String
locateAnyBar = liftIO maybeFindAnyBar >>= f
  where f (Just x) = return x
        f Nothing = appError AnyBarNotFound

launchApp :: String -> App ()
launchApp = (>>= f) . liftIO . openApp
  where f True = pure ()
        f False = appError LaunchFailed

launchAnyBar :: App ()
launchAnyBar = locateAnyBar >>= launchApp
