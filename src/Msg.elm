module Msg exposing (Msg(..))

import Cell exposing (Cell)
import Position exposing (Position)
import Time


type Msg
    = NoOp
    | Mine
    | ClickedCellAt Position
    | BuyAt Position Cell
    | BuyComputer
    | OnTick Time.Posix
