module WithAnyBar.Types where
import Control.Monad.Except (ExceptT, runExceptT, throwError)

type App = ExceptT AppError IO

data AppError = AnyBarNotFound
              | OpenFailed
              | LaunchFailed
              deriving (Eq, Show)

appError :: AppError -> App a
appError = throwError

runApp :: App a -> IO (Either AppError a)
runApp = runExceptT
