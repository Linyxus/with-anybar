module WithAnyBar.App where
import WithAnyBar.Types
import WithAnyBar.Blink
import Utils.AnyBar (maybeFindAnyBar)
import Utils.Shell (openApp, args, runCommand)
import Utils.Network (sendMsgTo)
import Control.Monad.IO.Class (liftIO)
import Control.Monad (void)
import Control.Concurrent (forkOS)

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

notify :: String -> BarColor -> IO ()
notify port color = sendMsgTo (showColor color) "127.0.0.1" port

checkArgs :: [String] -> App [String]
checkArgs [] = appError EmptyCommand
checkArgs ("":xs) = checkArgs xs
checkArgs (x:xs) = pure $ x : xs

execute :: App Bool
execute = liftIO args >>= checkArgs >>= liftIO . runCommand

black :: IO ()
black = notify "1738" Black

white :: IO ()
white = notify "1738" White

green :: IO ()
green = notify "1738" Green

red :: IO ()
red = notify "1738" Red

blink :: Signal -> IO ()
blink = blinker black white

startBlink :: Signal -> App ()
startBlink = liftIO . void . forkOS . blink

stopBlink :: Signal -> App ()
stopBlink = liftIO . terminate
