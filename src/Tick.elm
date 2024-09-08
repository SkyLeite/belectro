module Tick exposing (..)

import Time


tickMs : Float
tickMs =
    1000


costGrowth : Float
costGrowth =
    2


onTick : (Time.Posix -> msg) -> Sub msg
onTick =
    Time.every tickMs
