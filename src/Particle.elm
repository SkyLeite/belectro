module Particle exposing (view)

import Animator
import Animator.Inline
import Html exposing (Html, div)
import Html.Attributes exposing (id)
import Position exposing (Position)


margin : Int
margin =
    10


chipSize : Int
chipSize =
    50


edgeDistance : Int
edgeDistance =
    (chipSize // 2) + margin


travelDistance : Int
travelDistance =
    edgeDistance * 2


view : Animator.Timeline Position -> Html msg
view position =
    div
        [ id "particle"
        , Animator.Inline.transform
            { position =
                { x =
                    Animator.move position <|
                        \( x, _ ) ->
                            Animator.at <|
                                toFloat <|
                                    (edgeDistance + (travelDistance * x))

                -- toFloat ((x + 1) * 30)
                , y =
                    Animator.move position <|
                        \( _, y ) ->
                            Animator.at <|
                                toFloat <|
                                    (edgeDistance + (travelDistance * y))
                }
            , scale = 1.0
            , rotate = 0.0
            }
        ]
        []
