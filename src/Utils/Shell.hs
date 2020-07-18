module Utils.Shell where

import System.Process (readCreateProcess, shell, spawnProcess, waitForProcess)
import System.Exit (ExitCode(..))

getCurrentUser :: IO String
getCurrentUser = strip <$> readCreateProcess (shell "whoami") ""

stripBefore :: String -> String
stripBefore ('\n':xs) = stripBefore xs
stripBefore xs = xs

strip :: String -> String
strip = reverse . stripBefore . reverse . stripBefore

openApp :: String -> IO Bool
openApp p = fmap f $ spawnProcess "open" ["-a", p] >>= waitForProcess
  where f ExitSuccess = True
        f (ExitFailure _) = False
