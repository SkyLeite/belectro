module Cell exposing (..)

import Computer
import GameState exposing (GameState)


type Cell
    = None
    | Computer
    | Antenna


toChar : Cell -> String
toChar cell =
    case cell of
        None ->
            "◻"

        Computer ->
            "🖥️"

        Antenna ->
            "📡"


toString : Cell -> String
toString cell =
    case cell of
        None ->
            "None"

        Computer ->
            "Computer"

        Antenna ->
            "Antenna"


toAnchorName : Int -> Int -> String
toAnchorName x y =
    "--cell-" ++ String.fromInt x ++ "-" ++ String.fromInt y


purchaseableCells : List ( Cell, GameState -> Int, GameState -> Result String GameState )
purchaseableCells =
    [ ( Computer, Computer.cost, Computer.buy ) ]


buy : Cell -> GameState -> Result String GameState
buy cell =
    case cell of
        None ->
            \game -> Ok game

        Computer ->
            Computer.buy

        Antenna ->
            \game -> Ok game
