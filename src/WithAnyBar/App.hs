module WithAnyBar.App where
import WithAnyBar.Types
import Utils.AnyBar (maybeFindAnyBar)
import Utils.Shell (openApp, args, runCommand)
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

checkArgs :: [String] -> App [String]
checkArgs [] = appError EmptyCommand
checkArgs ("":xs) = checkArgs xs
checkArgs (x:xs) = pure $ x : xs

execute :: App Bool
execute = liftIO args >>= checkArgs >>= liftIO . runCommand
