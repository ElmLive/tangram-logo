module Pieces exposing (..)

import String
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Point =
    ( Float, Float )


to : List Point -> Int -> Point
to ps pointNumber =
    ps
        |> List.drop (pointNumber - 1)
        |> List.head
        |> Maybe.withDefault ( 0, 0 )


snap : Int -> Point -> List Point -> List Point
snap pointNumber snapTarget ps =
    case
        ps
            |> List.drop (pointNumber - 1)
            |> List.head
    of
        Just pivot ->
            ps
                |> sub pivot
                |> add snapTarget

        Nothing ->
            ps


sub : Point -> List Point -> List Point
sub ( x, y ) =
    add ( -x, -y )


add : Point -> List Point -> List Point
add ( dx, dy ) ps =
    List.map (\( x, y ) -> ( x + dx, y + dy )) ps


flip : List Point -> List Point
flip ps =
    List.map (\( x, y ) -> ( -x, y )) ps


rotate : Float -> List Point -> List Point
rotate angle ps =
    let
        rad =
            degrees angle

        rotate_ ( x, y ) =
            ( cos rad * x + sin rad * y
            , sin rad * -x + cos rad * y
            )
    in
        List.map rotate_ ps


triangle : Float -> List Point
triangle size =
    [ ( 0, 0 )
    , ( size, 0 )
    , ( 0, size )
    ]


parallelogram : List Point
parallelogram =
    [ ( 0, 0 )
    , ( 1, 0 )
    , ( 2, -1 )
    , ( 1, -1 )
    ]


square : List Point
square =
    [ ( 0, 0 )
    , ( 1, 0 )
    , ( 1, 1 )
    , ( 0, 1 )
    ]


draw : String -> List Point -> Svg msg
draw color ps =
    polygon
        [ ps
            |> List.concatMap (\( x, y ) -> [ x, y ])
            |> List.map toString
            |> String.join ","
            |> points
        , fill color
        , stroke "white"
        , strokeWidth "0.1"
        ]
        []
