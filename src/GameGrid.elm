module GameGrid exposing (GameGrid, adjacent, findPath, get, movesFrom, new, place, view)

import AStar
import Array
import Cell exposing (Cell)
import Grid exposing (Grid)
import Html exposing (Html, code)
import Html.Attributes exposing (id, style)
import Maybe.Extra
import Msg exposing (Msg(..))
import Set exposing (Set)
import Views.Cell as Cell


type alias GameGrid =
    Grid Cell


width : number
width =
    8


height : number
height =
    8


new : GameGrid
new =
    Grid.repeat width height Cell.None
        |> Grid.set ( 1, 1 ) Cell.Power


view : GameGrid -> Html Msg
view grid =
    code
        [ id "grid"
        , style "grid-template-rows" ("repeat(" ++ String.fromInt width ++ ", 1fr)")
        , style "grid-template-columns" ("repeat(" ++ String.fromInt height ++ ", 1fr)")
        ]
        (grid
            |> Grid.rows
            |> Array.indexedMap (\y row -> Array.indexedMap (\x cell -> Cell.view cell (Msg.ClickedCellAt x y)) row)
            |> Array.map Array.toList
            |> Array.toList
            |> List.concat
        )


get : Int -> Int -> GameGrid -> Cell
get x y grid =
    Grid.get ( x, y ) grid |> Maybe.withDefault Cell.None


place : Int -> Int -> Cell -> GameGrid -> Result String GameGrid
place x y cell grid =
    case Grid.get ( x, y ) grid of
        Just Cell.None ->
            Ok <| Grid.set ( x, y ) cell grid

        Nothing ->
            Ok <| Grid.set ( x, y ) cell grid

        _ ->
            Err "Cell is occupied"


adjacent : ( Int, Int ) -> Set ( Int, Int )
adjacent ( x, y ) =
    let
        adjacentPositions : List ( Int, Int )
        adjacentPositions =
            [ ( x - 1, y + 0 )
            , ( x + 1, y + 0 )
            , ( x + 0, y + 1 )
            , ( x + 0, y - 1 )
            ]
    in
    Set.fromList adjacentPositions


movesFrom : GameGrid -> ( Int, Int ) -> Set ( Int, Int )
movesFrom grid ( x, y ) =
    adjacent ( x, y )
        |> Set.filter (\pos -> Maybe.Extra.unwrap False Cell.isFilled <| Grid.get pos grid)


findPath : ( Int, Int ) -> ( Int, Int ) -> GameGrid -> Maybe (List ( Int, Int ))
findPath from to grid =
    AStar.findPath AStar.straightLineCost (movesFrom grid) from to


find : (Cell -> Bool) -> GameGrid -> Maybe Cell
find f grid =
    Grid.rows
