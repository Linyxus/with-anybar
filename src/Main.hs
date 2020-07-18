module Main where
import WithAnyBar.Types
import WithAnyBar.App

main :: IO ()
main = runApp (notify "1738" Black >> execute >>= go) >>= f
  where f (Left e) = print e
        f (Right _) = pure ()
        go True = notify "1738" White
        go False = notify "1738" Red
