module GontoArt exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)

main =
  box


box =
  div [ boxStyle ] rows


cellLength = 30
colCount = 15
rowCount = 10


boxStyle =
  style
    [ ("margin", "50px")
    , ("boxShadow", "0px 1px 4px 0px rgba(0,0,0,0.2)")
    , ("backgroundColor", "rgba(0,0,0,0.1)")
    , ("position", "relative")
    , ("width", (toString ((cellLength + 1) * colCount)) ++ "px")
    , ("height", (toString ((cellLength + 1) * rowCount)) ++ "px")
    ]


rows =
  [0..(rowCount - 1)]
    |> List.concatMap ( \i -> List.map ( \j -> (i, j) ) [0..(colCount - 1)] )
    |> List.map ( \ (i,j) -> div [ cellStyle i j ] [] )


cellStyle i j =
  style
    [ ("position", "absolute")
    , ("backgroundColor", "#fff")
    , ("width", (toString cellLength) ++ "px")
    , ("height", (toString cellLength) ++ "px")
    , ("left", (toString (j * (cellLength + 1))) ++ "px")
    , ("top", (toString (i * (cellLength + 1))) ++ "px")
    ]
