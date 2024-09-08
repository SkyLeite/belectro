module Model exposing (Model, closeDialog, init, mapGame, mapGameResult, placeInGrid)

import Cell exposing (Cell)
import Dialog exposing (Dialog)
import GameGrid exposing (GameGrid)
import GameState exposing (GameState)


type alias Model =
    { grid : GameGrid
    , dialog : Maybe Dialog
    , game : GameState
    }


init : flags -> ( Model, Cmd msg )
init _ =
    ( { grid = GameGrid.new
      , dialog = Nothing
      , game = GameState.new
      }
    , Cmd.none
    )


placeInGrid : Int -> Int -> Cell -> Model -> Result String Model
placeInGrid x y cell model =
    GameGrid.place x y cell model.grid
        |> Result.map (\g -> { model | grid = g })


closeDialog : Model -> Model
closeDialog m =
    { m | dialog = Nothing }


mapGame : (GameState -> GameState) -> Model -> Model
mapGame fn model =
    { model | game = fn model.game }


mapGameResult : (GameState -> Result String GameState) -> Model -> Result String Model
mapGameResult fn model =
    case fn model.game of
        Ok newGame ->
            Ok { model | game = newGame }

        Err err ->
            Err err
