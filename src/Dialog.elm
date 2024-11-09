module Dialog exposing (Dialog, Kind(..), view)

import Cell
import GameState exposing (GameState)
import Html exposing (Attribute, Html, article, button, div, header, p, section, span, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)
import Msg exposing (Msg)
import Position exposing (Position)
import Views.Chip


type alias Dialog =
    { kind : Kind, anchor : ( Int, Int ) }


type Kind
    = Buy


view : Dialog -> GameState -> Html Msg
view d =
    case d.kind of
        Buy ->
            buyDialog d.anchor



-- INTERNAL


dialog : List (Attribute msg) -> List (Html msg) -> Html msg
dialog attributes body =
    article (class "dialog" :: attributes)
        [ header [ class "dialog-close" ] [ text "x" ]
        , section [ class "dialog-body" ] body
        ]


buyDialog : Position -> GameState -> Html Msg
buyDialog position game =
    dialog
        [ id "buy-dialog"
        ]
        [ p [] [ text "Which chip do you want to purchase?" ]
        , div [ class "cells" ] <|
            List.map
                (\( cell, costFn, _ ) ->
                    Views.Chip.new { name = Cell.toString cell, image = Cell.toChar cell }
                        |> Views.Chip.withCost (costFn game)
                        |> Views.Chip.withOnClick (Msg.BuyAt position cell)
                        |> Views.Chip.view
                )
                Cell.purchaseableCells
        ]
