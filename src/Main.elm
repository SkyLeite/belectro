module Main exposing (main, update, view)

import Basics.Extra exposing (flip)
import Browser exposing (Document)
import Cell
import Computer
import Dialog exposing (Dialog)
import GameGrid exposing (GameGrid)
import Html exposing (Html, button, div, main_, span, text)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)
import Html.Extra exposing (viewMaybe)
import Model exposing (Model)
import Msg exposing (..)
import Tick
import Util exposing (with)



-- Make a line go through all the components on each Tick, getting added and multiplied along the way
-- Like a hand being evaluated in Balatro


main : Program () Model Msg
main =
    Browser.document
        { init = Model.init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Tick.onTick OnTick


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model |> with Cmd.none

        Mine ->
            model
                |> Model.mapGame (\g -> { g | coins = g.coins + 1 })
                |> with Cmd.none

        BuyComputer ->
            model |> with Cmd.none

        OnTick _ ->
            model
                |> Model.mapGame Computer.tick
                |> with Cmd.none

        ClickedCellAt x y ->
            case GameGrid.get x y model.grid of
                Cell.None ->
                    { model | dialog = Just <| Dialog Dialog.Buy ( x, y ) }
                        |> with Cmd.none

                _ ->
                    model |> with Cmd.none

        BuyAt x y cell ->
            model
                |> Model.mapGameResult (Cell.buy cell)
                |> Result.andThen (Model.placeInGrid x y cell)
                |> Result.map Model.closeDialog
                |> Result.withDefault (Model.closeDialog model)
                |> with Cmd.none


view : Model -> Document Msg
view model =
    { title = "Network"
    , body =
        [ main_ []
            -- [ div [ id "test" ] [ Views.Cell.view Cell.Computer ]
            [ -- div []
              --    [ span [] [ text <| String.fromInt model.game.coins, text " coins" ]
              --    , button [ onClick Mine ] [ text "Mine!" ]
              --    ]
              -- Computer.view model.game
              GameGrid.view model.grid
            , viewMaybe (flip Dialog.view model.game) model.dialog
            ]
        ]
    }
