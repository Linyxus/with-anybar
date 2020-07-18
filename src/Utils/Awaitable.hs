module Utils.Awaitable where
import Control.Concurrent
import Control.Monad (void, sequence, replicateM, zipWithM_)

type Awaitable a = MVar a -> IO ()

awaitable :: IO a -> Awaitable a
awaitable io v = void . forkIO $ io >>= putMVar v

await :: Awaitable a -> IO a
await f = do
  v <- newEmptyMVar
  f v
  takeMVar v

awaits :: [Awaitable a] -> IO [a]
awaits fs = do
  vs <- replicateM n newEmptyMVar
  zipWithM_ ($) fs vs
  mapM takeMVar vs
  where n = length fs
