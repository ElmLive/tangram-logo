module Camera exposing (..)

import Pieces exposing (..)
import Svg exposing (Svg, svg)
import Svg.Attributes exposing (viewBox)


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
                |> rotate 90

        big2 =
            triangle 2
                |> rotate -90
                |> snap 2 (to big1 3)

        med =
            triangle (sqrt 2)
                |> rotate 225
                |> snap 1 (to big1 2)
                |> add ( 0, 0.5 )

        par =
            parallelogram
                |> rotate 90
                |> Pieces.flip
                |> snap 3 (to med 1)
    in
        svg [ viewBox "-4 -5 10 10" ]
            [ triangle 1
                |> rotate 180
                |> snap 2 (to big1 2)
                |> draw colors.orange
            , square
                |> snap 3 (to big2 1)
                |> draw colors.green
            , triangle 1
                |> rotate 0
                |> snap 3 (to big2 1)
                |> draw colors.orange
            , med
                |> draw colors.blue
            , par
                |> draw colors.green
            , big1
                |> draw colors.gray
            , big2
                |> draw colors.blue
            ]
