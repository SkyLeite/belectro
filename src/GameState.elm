module GameState exposing (GameState, new)


type alias GameState =
    { coins : Int, computers : Int }


new : GameState
new =
    { coins = 0, computers = 0 }
