module Tests exposing (..)

import Cell
import Expect
import GameGrid
import Position exposing (Position)
import Test exposing (Test)


suite : Test
suite =
    Test.describe "Tests"
        [ Test.describe "GameGrid"
            [ Test.describe "find"
                [ Test.test "returns the correct position of a cell" <|
                    \_ ->
                        let
                            position : Position
                            position =
                                ( 5, 5 )
                        in
                        GameGrid.new
                            |> GameGrid.set position Cell.Antenna
                            |> GameGrid.find (\c -> c == Cell.Antenna)
                            |> Expect.equal (Just position)
                , Test.test "returns the position of the first cell when there are multiple" <|
                    \_ ->
                        let
                            position : Position
                            position =
                                ( 5, 5 )

                            position2 : ( number, number )
                            position2 =
                                ( 6, 6 )
                        in
                        GameGrid.new
                            |> GameGrid.set position2 Cell.Antenna
                            |> GameGrid.set position Cell.Antenna
                            |> GameGrid.find (\c -> c == Cell.Antenna)
                            |> Expect.equal (Just position)
                ]
            , Test.describe "findAll"
                [ Test.test "returns the correct position of matching cells" <|
                    \_ ->
                        let
                            position : Position
                            position =
                                ( 5, 5 )

                            position2 : ( number, number )
                            position2 =
                                ( 6, 6 )
                        in
                        GameGrid.new
                            |> GameGrid.set position Cell.Antenna
                            |> GameGrid.set position2 Cell.Antenna
                            |> GameGrid.findAll (\c -> c == Cell.Antenna)
                            |> Expect.equalLists [ position, position2 ]
                ]
            ]
        ]
