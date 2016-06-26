module GontoArt exposing (..)

import Html exposing (br, button, div, h1, img, p, text)
import Html.Attributes exposing (alt, attribute, class, src, style)
import Html.Events exposing (onClick)
import Html.App
import Set exposing (Set)


main =
  Html.App.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- MODEL

type alias Position =
  (Int, Int)


type alias Model =
  { onPositions : Set Position
  }


model =
  Model Set.empty


-- UPDATE

type Msg
  = TogglePosition Position


update msg model =
  case msg of
    TogglePosition position ->
      { model | onPositions = togglePosition position model.onPositions }


togglePosition position set =
  if Set.member position set then
    Set.remove position set
  else
    Set.insert position set


-- VIEW

view { onPositions } =
  div []
   [ header
   , box onPositions
   , footer onPositions
   ]

header =
  div [ class "header" ]
    [ gonto
    , intro
    ]


gonto =
  img
    [ src "https://gon.to/images/home-about-portrait.jpg"
    , alt "Gonto"
    ]
    []


intro =
  h1 []
    [ text "Hi! Make some art using my all time"
    , br [] []
    , text "favorite emoji"
    ]


box onPositions =
  div [ class "box", boxStyle ] (rows onPositions)


cellLength =
  40


colCount =
  15


rowCount =
  10


boxStyle =
  let
    size count =
      (toString ((cellLength + 1) * count - 1)) ++ "px"
  in
    style
    [ ("width", size colCount)
    , ("height", size rowCount)
    ]


positions =
  List.concatMap
    (\i -> List.map (\j -> (i, j)) [0..(colCount - 1)])
    [0..(rowCount - 1)]


rows onPositions =
  List.map (\(i, j) -> cell i j onPositions) positions


cell i j onPositions =
  div
    [ cellStyle i j onPositions
    , class (cellClass i j onPositions)
    , onClick (TogglePosition (i, j))
    ]
    []


cellStyle i j onPositions =
  style
    [ ("width", (toString cellLength) ++ "px")
    , ("height", (toString cellLength) ++ "px")
    , ("left", (toString (j * (cellLength + 1))) ++ "px")
    , ("top", (toString (i * (cellLength + 1))) ++ "px")
    ]


cellClass i j onPositions =
  let
    base =
      "cell cell-" ++ (toString i) ++ "-" ++ (toString j)
  in
    if Set.member (i, j) onPositions then
      base ++ " on"
    else
      base


footer onPositions =
  div [ class "footer" ]
    [ p []
        [ text "Once you are ready, you can"
        , copyButton onPositions
        , text "it and"
        ]
    , p [] [ text " share it with your friends in Slack." ]
    ]


copyButton onPositions =
  button
    [ attribute "data-clipboard-text" (textOutput onPositions)
    , class "btn-copy"
    ]
    [ text "copy" ]


textOutput onPositions =
  let
    cellText i j =
      if Set.member (i, j) onPositions then
        ":muscle:"
      else
        "        "

    rowText i =
      List.map (cellText i) [0..(colCount - 1)]

  in
    List.map rowText [0..(rowCount - 1)]
      |> List.intersperse ["\n"]
      |> List.concat
      |> List.foldr (++) ""
