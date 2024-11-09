module Model exposing (Model, animator, closeDialog, init, mapGame, mapGameResult, placeInGrid)

import Animator exposing (Animator)
import Cell exposing (Cell)
import Dialog exposing (Dialog)
import GameGrid exposing (GameGrid)
import GameState exposing (GameState)
import Position exposing (Position)


type alias Model =
    { grid : GameGrid
    , dialog : Maybe Dialog
    , game : GameState
    , particle : Animator.Timeline Position
    }


init : flags -> ( Model, Cmd msg )
init _ =
    ( { grid = GameGrid.new
      , dialog = Nothing
      , game = GameState.new
      , particle = Animator.init ( 0, 0 )
      }
    , Cmd.none
    )


placeInGrid : Position -> Cell -> Model -> Result String Model
placeInGrid position cell model =
    GameGrid.place position cell model.grid
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


animator : Animator Model
animator =
    Animator.animator
        |> Animator.watching .particle (\newParticle model -> { model | particle = newParticle })
