module GameState exposing (GameState, new)


type alias GameState =
    { coins : Int, computers : Int }


new : GameState
new =
    { coins = 100000, computers = 0 }
