module Main exposing (main, update, view)

import Animator
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
import Position exposing (Position)
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
subscriptions model =
    Model.animator |> Animator.toSubscription OnTick model


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

        Play ->
            let
                pathToEnd : Maybe (List Position)
                pathToEnd =
                    Debug.log "path" <|
                        case ( GameGrid.start model.grid, GameGrid.finish model.grid ) of
                            ( Just start, Just finish ) ->
                                GameGrid.findPath start finish model.grid
                                    |> Maybe.map ((::) start)

                            _ ->
                                Nothing

                newModel : Model
                newModel =
                    case pathToEnd of
                        Just positions ->
                            { model
                                | particle =
                                    Animator.interrupt
                                        (List.concatMap
                                            (\p ->
                                                [ Animator.wait (Animator.millis 300)
                                                , Animator.event (Animator.seconds 1) p
                                                ]
                                            )
                                            positions
                                        )
                                        model.particle
                            }

                        Nothing ->
                            model
            in
            newModel |> with Cmd.none

        OnTick newTime ->
            model
                |> Animator.update newTime Model.animator
                |> Model.mapGame Computer.tick
                |> with Cmd.none

        ClickedCellAt position ->
            case GameGrid.get position model.grid of
                Cell.None ->
                    { model | dialog = Just <| Dialog Dialog.Buy position }
                        |> with Cmd.none

                _ ->
                    model |> with Cmd.none

        BuyAt position cell ->
            model
                |> Model.mapGameResult (Cell.buy cell)
                |> Result.andThen (Model.placeInGrid position cell)
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
              GameGrid.view model.particle model.grid
            , button [ onClick Play ] [ text "Play" ]
            , viewMaybe (flip Dialog.view model.game) model.dialog
            ]
        ]
    }
