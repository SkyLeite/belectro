module GameGrid exposing (GameGrid, find, findAll, findPath, finish, get, indexed, movesFrom, new, place, set, start, view)

import AStar
import Animator
import Array
import Cell exposing (Cell(..))
import Grid exposing (Grid)
import Html exposing (Html, code)
import Html.Attributes exposing (id, style)
import Msg exposing (Msg(..))
import Particle
import Position exposing (Position)
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
        |> Grid.set ( 3, 3 ) Cell.Output


set : Position -> Cell -> GameGrid -> GameGrid
set =
    Grid.set


view : Animator.Timeline Position -> GameGrid -> Html Msg
view particle grid =
    code
        [ id "grid"
        , style "grid-template-rows" ("repeat(" ++ String.fromInt width ++ ", 1fr)")
        , style "grid-template-columns" ("repeat(" ++ String.fromInt height ++ ", 1fr)")
        ]
        (Particle.view particle
            :: (grid
                    |> Grid.rows
                    |> Array.indexedMap (\y row -> Array.indexedMap (\x cell -> Cell.view cell (Msg.ClickedCellAt ( x, y ))) row)
                    |> Array.map Array.toList
                    |> Array.toList
                    |> List.concat
               )
        )


get : Position -> GameGrid -> Cell
get position grid =
    Grid.get position grid |> Maybe.withDefault Cell.None


place : Position -> Cell -> GameGrid -> Result String GameGrid
place position cell grid =
    case Grid.get position grid of
        Just Cell.None ->
            Ok <| Grid.set position cell grid

        Nothing ->
            Ok <| Grid.set position cell grid

        _ ->
            Err "Cell is occupied"


movesFrom : GameGrid -> Position -> Set Position
movesFrom grid pos =
    let
        maybeCell : Maybe Cell
        maybeCell =
            Grid.get pos grid
    in
    case maybeCell of
        Just cell ->
            Position.adjacent pos
                |> Set.filter
                    (\p ->
                        case Grid.get p grid of
                            Just adjCell ->
                                case ( Cell.isChip cell, Cell.isChip adjCell ) of
                                    ( True, True ) ->
                                        False

                                    ( True, False ) ->
                                        True

                                    ( False, True ) ->
                                        True

                                    ( False, False ) ->
                                        True

                            _ ->
                                False
                    )

        Nothing ->
            Set.empty


start : GameGrid -> Maybe Position
start =
    find (\c -> c == Cell.Power)


finish : GameGrid -> Maybe Position
finish =
    find (\c -> c == Cell.Output)


findPath : Position -> Position -> GameGrid -> Maybe (List ( Int, Int ))
findPath from to grid =
    AStar.findPath AStar.straightLineCost (movesFrom grid) from to


indexed : Grid a -> Grid ( Position, a )
indexed =
    Grid.indexedMap (\x y c -> ( ( x, y ), c ))


findAll : (Cell -> Bool) -> GameGrid -> List Position
findAll f =
    indexed
        >> Grid.foldl
            (\( ( x, y ), cell ) cells ->
                if f cell then
                    ( x, y ) :: cells

                else
                    cells
            )
            []
        >> List.reverse


find : (Cell -> Bool) -> GameGrid -> Maybe Position
find f =
    indexed
        >> Grid.foldl
            (\( ( x, y ), cell ) acc ->
                case acc of
                    Just _ ->
                        acc

                    Nothing ->
                        if f cell then
                            Just ( x, y )

                        else
                            Nothing
            )
            Nothing
