module Icon exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import Svg exposing (path, svg)
import Svg.Attributes as SvgAttr


computer : Html msg
computer =
    svg
        [ SvgAttr.width "50"
        , SvgAttr.height "50"
        , SvgAttr.viewBox "0 0 50 50"
        , SvgAttr.fill "none"
        ]
        [ Svg.g
            [ SvgAttr.clipPath "url(#clip0_5_7104)"
            ]
            [ Svg.rect
                [ SvgAttr.x "0.25"
                , SvgAttr.y "0.25"
                , SvgAttr.width "49.5"
                , SvgAttr.height "49.5"
                , SvgAttr.rx "3.75"
                , SvgAttr.fill "#046307"
                , SvgAttr.stroke "black"
                , SvgAttr.strokeWidth "0.5"
                ]
                []
            , Svg.rect
                [ SvgAttr.x "5.00189"
                , SvgAttr.y "5"
                , SvgAttr.width "40"
                , SvgAttr.height "40"
                , SvgAttr.rx "1"
                , SvgAttr.fill "black"
                ]
                []
            , path
                [ SvgAttr.d "M30.7778 38H35.6889C36.4979 38 36.9024 38 37.2113 37.8426C37.4832 37.704 37.704 37.4832 37.8426 37.2113C38 36.9024 38 36.4979 38 35.6889V14.3111C38 13.5021 38 13.0977 37.8426 12.7887C37.704 12.5169 37.4832 12.2959 37.2113 12.1574C36.9024 12 36.4979 12 35.6889 12H27.3111C26.5021 12 26.0976 12 25.7887 12.1574C25.5168 12.2959 25.296 12.5169 25.1574 12.7887C25 13.0977 25 13.5021 25 14.3111V16.3333M22.1111 33.6667V38M17.7778 38H26.4444M16.6222 33.6667H27.6C29.2179 33.6667 30.027 33.6667 30.6449 33.3518C31.1884 33.0749 31.6304 32.6329 31.9073 32.0893C32.2222 31.4714 32.2222 30.6624 32.2222 29.0444V20.9556C32.2222 19.3376 32.2222 18.5287 31.9073 17.9107C31.6304 17.3671 31.1884 16.9252 30.6449 16.6482C30.027 16.3333 29.2179 16.3333 27.6 16.3333H16.6222C15.0043 16.3333 14.1953 16.3333 13.5774 16.6482C13.0338 16.9252 12.5918 17.3671 12.3149 17.9107C12 18.5287 12 19.3376 12 20.9556V29.0444C12 30.6624 12 31.4714 12.3149 32.0893C12.5918 32.6329 13.0338 33.0749 13.5774 33.3518C14.1953 33.6667 15.0043 33.6667 16.6222 33.6667Z"
                , SvgAttr.stroke "white"
                , SvgAttr.strokeWidth "2"
                , SvgAttr.strokeLinecap "round"
                ]
                []
            ]
        , Svg.defs []
            [ Svg.clipPath
                [ SvgAttr.id "clip0_5_7104"
                ]
                [ Svg.rect
                    [ SvgAttr.width "50"
                    , SvgAttr.height "50"
                    , SvgAttr.fill "white"
                    ]
                    []
                ]
            ]
        ]


connectorHorizontal : Html msg
connectorHorizontal =
    svg
        [ SvgAttr.width "140"
        , SvgAttr.height "140"
        , SvgAttr.viewBox "0 0 140 140"
        , SvgAttr.fill "none"
        ]
        [ Svg.line
            [ SvgAttr.y1 "69.5"
            , SvgAttr.x2 "140"
            , SvgAttr.y2 "69.5"
            , SvgAttr.stroke "black"
            ]
            []
        ]


connectorVertical : Html msg
connectorVertical =
    svg
        [ SvgAttr.width "140"
        , SvgAttr.height "140"
        , SvgAttr.viewBox "0 0 140 140"
        , SvgAttr.fill "none"
        ]
        [ Svg.line
            [ SvgAttr.x1 "69.5"
            , SvgAttr.y1 "140"
            , SvgAttr.x2 "69.5"
            , SvgAttr.stroke "black"
            ]
            []
        ]


connectorCross : Html msg
connectorCross =
    svg
        [ SvgAttr.width "140"
        , SvgAttr.height "140"
        , SvgAttr.viewBox "0 0 140 140"
        , SvgAttr.fill "none"
        ]
        [ Svg.line
            [ SvgAttr.y1 "69.5"
            , SvgAttr.x2 "140"
            , SvgAttr.y2 "69.5"
            , SvgAttr.stroke "black"
            ]
            []
        , Svg.line
            [ SvgAttr.x1 "69.5"
            , SvgAttr.y1 "140"
            , SvgAttr.x2 "69.5"
            , SvgAttr.stroke "black"
            ]
            []
        ]
