module ElmLogo exposing (..)

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
