module Position exposing (..)

import Set exposing (Set)


{-| Represents a position in a 2D grid
-}
type alias Position =
    ( Int, Int )


{-| Returns a set of positions adjacent to the given one.
Does not include diagonals. For that, use Position.neighbors.
-}
adjacent : Position -> Set Position
adjacent ( x, y ) =
    Set.fromList
        [ ( x - 1, y + 0 )
        , ( x + 1, y + 0 )
        , ( x + 0, y + 1 )
        , ( x + 0, y - 1 )
        ]


{-| Returns a set of positions that neighbor the given one, including diagonals.
-}
neighbors : Position -> Set Position
neighbors ( x, y ) =
    adjacent ( x, y )
        |> Set.insert ( x - 1, y - 1 )
        |> Set.insert ( x - 1, y + 1 )
        |> Set.insert ( x + 1, y - 1 )
        |> Set.insert ( x + 1, y + 1 )
