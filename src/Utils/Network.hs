module Utils.Network where
import Network.Socket
import Network.Socket.ByteString
import Data.ByteString (ByteString)
import Data.ByteString.Char8 (pack)

getUdpAddrInfo :: String -> String -> IO AddrInfo
getUdpAddrInfo host port = f <$> getAddrInfo (Just hints) (Just host) (Just port)
  where f [x] = x
        hints = defaultHints { addrFlags = [AI_NUMERICHOST, AI_NUMERICSERV], addrSocketType = Datagram }

sendMsgTo :: String -> String -> String -> IO ()
sendMsgTo msg host port = getUdpAddrInfo host port >>= go
  where go addr = do
          sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
          sendAllTo sock (pack msg) (addrAddress addr)
          close sock
