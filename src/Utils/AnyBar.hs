module Utils.AnyBar where

import Utils.Shell (getCurrentUser, openApp)
import System.Directory (doesDirectoryExist)

import Control.Applicative (liftA2, (<|>))

getSystemAnyBar :: String
getSystemAnyBar = "/Applications/AnyBar.app"

getAnyBarOfUser :: String -> String
getAnyBarOfUser u = "/Users/" ++ u ++ "/Applications/AnyBar.app"

maybeFindSysAnyBar :: IO (Maybe String)
maybeFindSysAnyBar = f <$> doesDirectoryExist getSystemAnyBar
  where f True = Just getSystemAnyBar
        f False = Nothing

maybeFindUserAnyBar :: IO (Maybe String)
maybeFindUserAnyBar = fmap getAnyBarOfUser getCurrentUser >>= doesDirectoryExist >>= f
  where f True = Just <$> fmap getAnyBarOfUser getCurrentUser
        f False = pure Nothing

maybeFindAnyBar :: IO (Maybe String)
maybeFindAnyBar = liftA2 (<|>) maybeFindSysAnyBar maybeFindUserAnyBar
