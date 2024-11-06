module Cell exposing (..)

import Computer
import Connector
import GameState exposing (GameState)


type Cell
    = None
    | Computer
    | Antenna
    | Connector ConnectorKind


type ConnectorKind
    = Horizontal
    | Vertical
    | Cross
    | Diagonal


toChar : Cell -> String
toChar cell =
    case cell of
        None ->
            "◻"

        Computer ->
            "🖥️"

        Antenna ->
            "📡"

        Connector _ ->
            "|"


toString : Cell -> String
toString cell =
    case cell of
        None ->
            "None"

        Computer ->
            "Computer"

        Antenna ->
            "Antenna"

        Connector _ ->
            "Connector"


toAnchorName : Int -> Int -> String
toAnchorName x y =
    "--cell-" ++ String.fromInt x ++ "-" ++ String.fromInt y


purchaseableCells : List ( Cell, GameState -> Int, GameState -> Result String GameState )
purchaseableCells =
    [ ( Computer, Computer.cost, Computer.buy )
    , ( Connector Horizontal, Connector.cost, Connector.buy )
    ]


buy : Cell -> GameState -> Result String GameState
buy cell =
    case cell of
        None ->
            \game -> Ok game

        Computer ->
            Computer.buy

        Antenna ->
            \game -> Ok game

        Connector _ ->
            Connector.buy
