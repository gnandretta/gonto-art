module GontoArt exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)

main =
  box


box =
  div [ boxStyle ] []


boxStyle =
  style
    [ ("width", "700px")
    , ("height", "500px")
    , ("margin", "50px")
    , ("boxShadow", "0px 1px 4px 0px rgba(0,0,0,0.2)")
    ]
