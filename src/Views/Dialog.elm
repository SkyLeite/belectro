module Views.Dialog exposing (..)

import Html exposing (Html)


type Dialog a
    = Dialog


type alias IDialog msg =
    { body : List (Html msg)
    }
