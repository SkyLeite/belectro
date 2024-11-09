module Views.Cell exposing (boardView, view)

import Cell exposing (..)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Icon
import Msg exposing (Msg)
import Position exposing (Position)


view : Cell -> msg -> Html msg
view cell msg =
    div [ class "cell", class <| cellClass cell, onClick msg ]
        [ icon cell ]


boardView : Cell -> Position -> Html Msg
boardView cell position =
    span
        [ class "board-cell"
        , onClick <| Msg.ClickedCellAt position
        , attribute "style" ("anchor-name: " ++ toAnchorName position)
        ]
        [ text <| toChar cell ]


icon : Cell -> Html msg
icon cell =
    case cell of
        Computer ->
            Icon.computer

        Connector conn ->
            case conn of
                Horizontal ->
                    Icon.connectorCross

                Vertical ->
                    Icon.connectorVertical

                Cross ->
                    Icon.connectorCross

                _ ->
                    div [] []

        None ->
            Icon.blank

        Antenna ->
            Icon.antenna

        Power ->
            Icon.power


cellClass : Cell -> String
cellClass cell =
    case cell of
        None ->
            "empty"

        Connector _ ->
            "connector"

        _ ->
            "cell-chip"
