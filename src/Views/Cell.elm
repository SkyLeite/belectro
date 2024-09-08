module Views.Cell exposing (boardView, view)

import Cell exposing (..)
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Msg exposing (Msg)


view : Cell -> msg -> Html msg
view cell msg =
    case cell of
        Cell.None ->
            div [ class "cell empty", onClick msg ] []

        x ->
            div [ class "cell", onClick msg ]
                [ span [ class "cell-contacts cell-contacts-x" ] []
                , span [ class "cell-contacts cell-contacts-y" ] []
                , div [ class "cell-chip" ]
                    [ span [ class "cell-icon" ] [ text <| Cell.toChar x ]
                    ]
                ]


boardView : Cell -> Int -> Int -> Html Msg
boardView cell x y =
    span
        [ class "board-cell"
        , onClick <| Msg.ClickedCellAt x y
        , attribute "style" ("anchor-name: " ++ toAnchorName x y)
        ]
        [ text <| toChar cell ]
