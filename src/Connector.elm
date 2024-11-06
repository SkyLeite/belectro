module Connector exposing (buy, cost)

import GameState exposing (GameState)


cost : GameState -> Int
cost game =
    0


buy : GameState -> Result String GameState
buy game =
    Ok game
