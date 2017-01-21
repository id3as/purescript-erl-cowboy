module Erl.Cowboy.Req where

import Data.Maybe (Maybe(..))
import Erl.Data.List (List)
import Erl.Data.Tuple (Tuple2, Tuple4)

foreign import data Req :: *

foreign import data Ok :: *
foreign import ok :: Ok

-- http_status() = non_neg_integer() | binary()
newtype StatusCode = StatusCode Int

type Headers = List (Tuple2 String String)

-- | Send the repply including the given body content
foreign import reply :: StatusCode -> Headers -> String -> Req -> Req

-- | Send the reply without setting the body
foreign import replyWithoutBody :: StatusCode -> Headers -> Req -> Req

-- Raw request

foreign import method :: Req -> String

data Version = HTTP1_0 | HTTP1_1 | HTTP2

foreign import versionImpl :: Version -> Version -> Version -> Req -> Version

version :: Req -> Version
version = versionImpl HTTP1_0 HTTP1_1 HTTP2

foreign import scheme :: Req -> String

foreign import host :: Req -> String

foreign import port :: Req -> Int

foreign import path :: Req -> String

foreign import qs :: Req -> String

-- cowboy_req:uri(3) - Reconstructed URI

foreign import headerImpl :: (forall a. Maybe a) -> (forall a. a -> Maybe a) -> String -> Req -> Maybe String

header :: String -> Req -> Maybe String
header = headerImpl Nothing Just

foreign import headers :: Req -> Headers

type IpAddress = Tuple4 Int Int Int Int

foreign import peer :: Req -> Tuple2 IpAddress Int
