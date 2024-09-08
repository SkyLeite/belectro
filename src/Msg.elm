module Msg exposing (Msg(..))

import Cell exposing (Cell)
import Time


type Msg
    = NoOp
    | Mine
    | ClickedCellAt Int Int
    | BuyAt Int Int Cell
    | BuyComputer
    | OnTick Time.Posix
