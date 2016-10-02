module Main exposing (..)

import String
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Point =
    ( Float, Float )


colors =
    { gray = "#5a6378"
    , green = "#83c833"
    , orange = "#efa500"
    , blue = "#5fb4ca"
    }


main : Svg msg
main =
    let
        big1 =
            triangle 2
                |> rotate (45 + 180)

        big2 =
            triangle 2
                |> rotate -45

        par =
            parallelogram
                |> rotate -45
                |> snap 1 (to big1 3)
    in
        svg [ viewBox "-3 -3 10 10" ]
            [ big1
                |> draw colors.gray
            , big2
                |> draw colors.blue
            , triangle 1
                |> rotate (45 + 90)
                |> draw colors.orange
            , par
                |> draw colors.green
            , triangle (sqrt 2)
                |> rotate -90
                |> snap 3 (to par 4)
                |> draw colors.blue
            , square
                |> rotate 45
                |> draw colors.green
            , triangle 1
                |> rotate 45
                |> snap 3 (to big2 2)
                |> draw colors.orange
            ]


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


rotate : Float -> List Point -> List Point
rotate angle ps =
    let
        rad =
            degrees angle

        rotate' ( x, y ) =
            ( cos rad * x + sin rad * y
            , sin rad * -x + cos rad * y
            )
    in
        List.map rotate' ps


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
