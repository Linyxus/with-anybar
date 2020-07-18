module WithAnyBar.Blink where
import Control.Concurrent (threadDelay)
import Control.Concurrent.MVar (MVar, isEmptyMVar, putMVar, newEmptyMVar, takeMVar)
import Control.Monad (forever)
import Utils.Awaitable

type Signal = MVar ()

signal :: IO Signal
signal = newEmptyMVar

sleep :: Double -> IO ()
sleep = threadDelay . round . (*1e6)

blinker :: IO () -> IO () -> Signal -> IO ()
blinker on off sig = go
  where go = isEmptyMVar sig >>= f
        f False = takeMVar sig
        f True = on >> sleep 0.5 >> off >> sleep 0.5 >> go

terminate :: Signal -> IO ()
terminate sig = putMVar sig () >> putMVar sig ()
