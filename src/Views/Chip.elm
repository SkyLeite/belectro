module Views.Chip exposing (Chip, new, view, withCost, withOnClick)

import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (attributeMaybe)
import Html.Events exposing (onClick)


type Chip msg
    = Chip Fields (OptionalFields msg)


type alias Fields =
    { name : String, image : String }


type alias OptionalFields msg =
    { cost : Maybe Int, onClick : Maybe msg }


view : Chip msg -> Html msg
view (Chip fields opt) =
    button [ class "chip", attributeMaybe onClick opt.onClick ]
        [ span [ class "chip-image" ] [ text fields.image ]
        , span [ class "chip-name" ] [ text fields.name ]
        , div [ class "chip-contacts" ] []
        ]


new : Fields -> Chip msg
new fields =
    Chip fields { cost = Nothing, onClick = Nothing }


withCost : Int -> Chip msg -> Chip msg
withCost cost (Chip fields opt) =
    Chip fields { opt | cost = Just cost }


withOnClick : msg -> Chip msg -> Chip msg
withOnClick onClick (Chip fields opt) =
    Chip fields { opt | onClick = Just onClick }
