module Computer exposing (..)

import GameState exposing (GameState)
import Html exposing (Html, code, section, span, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Html.Extra exposing (viewIf)
import Tick


view : GameState -> Html msg
view game =
    viewIf (shouldShow game) <|
        section [ id "computer" ]
            [ code [] [ text <| String.fromInt game.computers, text " Computers" ]
            ]


baseCost : number
baseCost =
    10


cost : GameState -> Int
cost game =
    ceiling <| baseCost + (toFloat game.computers ^ Tick.costGrowth)


shouldShow : GameState -> Bool
shouldShow game =
    game.coins >= baseCost || game.computers > 0


buy : GameState -> Result String GameState
buy game =
    if game.coins >= cost game then
        Ok
            { game
                | coins = game.coins - cost game
                , computers = game.computers + 1
            }

    else
        Err "Insuficient funds"


tick : GameState -> GameState
tick model =
    let
        coinRate =
            1
    in
    { model | coins = model.coins + (coinRate * model.computers) }
