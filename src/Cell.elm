module Cell exposing (..)

import Computer
import Connector
import GameState exposing (GameState)
import Position exposing (Position)


type Cell
    = None
    | Computer
    | Antenna
    | Connector ConnectorKind
    | Power
    | Output


type ConnectorKind
    = Horizontal
    | Vertical
    | Cross
    | Diagonal


isChip : Cell -> Bool
isChip cell =
    case cell of
        Connector _ ->
            False

        _ ->
            True


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

        Power ->
            "Z"

        Output ->
            "O"


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

        Power ->
            "Power"

        Output ->
            "Output"


toAnchorName : Position -> String
toAnchorName ( x, y ) =
    "--cell-" ++ String.fromInt x ++ "-" ++ String.fromInt y


purchaseableCells : List ( Cell, GameState -> Int, GameState -> Result String GameState )
purchaseableCells =
    [ ( Computer, Computer.cost, Computer.buy )
    , ( Connector Horizontal, Connector.cost, Connector.buy )
    ]


isFilled : Cell -> Bool
isFilled cell =
    case cell of
        None ->
            False

        _ ->
            True


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

        Power ->
            \game -> Ok game

        Output ->
            \game -> Ok game
