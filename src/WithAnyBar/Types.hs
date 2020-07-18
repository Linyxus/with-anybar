module WithAnyBar.Types where
import Control.Monad.Except (ExceptT, runExceptT, throwError)
import Data.Char (toLower)

type App = ExceptT AppError IO

data AppError = AnyBarNotFound
              | OpenFailed
              | LaunchFailed
              | EmptyCommand
              deriving (Eq, Show)

data BarColor = White
              | Red
              | Orange
              | Yellow
              | Green
              | Cyan
              | Blue
              | Purple
              | Black
              | Question
              | Exclamation
              | None
              deriving (Eq, Show)

appError :: AppError -> App a
appError = throwError

runApp :: App a -> IO (Either AppError a)
runApp = runExceptT

showColor :: BarColor -> String
showColor = fmap toLower . show
