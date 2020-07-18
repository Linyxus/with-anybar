module WithAnyBar.App where
import WithAnyBar.Types
import Utils.AnyBar (maybeFindAnyBar)
import Utils.Shell (openApp)
import Utils.Network (sendMsgTo)
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

notify :: String -> BarColor -> App ()
notify port color = liftIO $ sendMsgTo (showColor color) "127.0.0.1" port
