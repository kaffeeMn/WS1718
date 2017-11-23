-- run "nc localhost 4242" in a different terminal
module Main where

import Network.Socket


-- type definitions
type Msg = String


-- methods
main :: IO()
main = do

    skt <- socket AF_INET Stream 0
    setSocketOption skt ReuseAddr 1
    bind skt (SockAddrInet 4242 iNADDR_ANY)
    listen skt 2
    loop skt

loop :: Socket -> IO()
loop skt = do
    connection <- accept skt
    run_connection connection
    loop skt

run_connection :: (Socket, SockAddr) -> IO()
run_connection (skt, _) = do
    send skt "Is this working?"
    close skt
