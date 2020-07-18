module Main where
import WithAnyBar.Types
import WithAnyBar.App
import WithAnyBar.Blink (signal)
import Control.Concurrent (threadDelay, forkIO)
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = (>>= f) . runApp $ do
  sig <- liftIO signal
  liftIO white
  startBlink sig
  execute >>= go sig
  where f (Left e) = print e
        f (Right _) = pure ()
        go sig True = stopBlink sig >> liftIO green
        go sig False = stopBlink sig >> liftIO red
