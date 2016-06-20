module GontoArt exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)
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

type alias Position = (Int, Int)

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

view {onPositions} =
  box onPositions


box onPositions =
  div [ boxStyle ] (rows onPositions)


cellLength = 40
colCount = 15
rowCount = 10
imageUrl = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAAAXNSR0IArs4c6QAAAAlwSFlzAAALEwAACxMBAJqcGAAAA6ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4wIj4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAgICAgICAgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iPgogICAgICAgICA8eG1wOk1vZGlmeURhdGU+MjAxNi0wNi0xOVQxOTowNjo3MzwveG1wOk1vZGlmeURhdGU+CiAgICAgICAgIDx4bXA6Q3JlYXRvclRvb2w+UGl4ZWxtYXRvciAzLjU8L3htcDpDcmVhdG9yVG9vbD4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6Q29tcHJlc3Npb24+NTwvdGlmZjpDb21wcmVzc2lvbj4KICAgICAgICAgPHRpZmY6UmVzb2x1dGlvblVuaXQ+MjwvdGlmZjpSZXNvbHV0aW9uVW5pdD4KICAgICAgICAgPHRpZmY6WVJlc29sdXRpb24+NzI8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlhSZXNvbHV0aW9uPjcyPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+NDA8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpDb2xvclNwYWNlPjE8L2V4aWY6Q29sb3JTcGFjZT4K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"


boxStyle =
  style
    [ ("margin", "50px")
    , ("boxShadow", "0px 1px 4px 0px rgba(0,0,0,0.2)")
    , ("backgroundColor", "rgba(0,0,0,0.1)")
    , ("position", "relative")
    , ("width", (toString ((cellLength + 1) * colCount)) ++ "px")
    , ("height", (toString ((cellLength + 1) * rowCount)) ++ "px")
    ]


rows onPositions =
  [0..(rowCount - 1)]
    |> List.concatMap ( \i -> List.map ( \j -> (i, j) ) [0..(colCount - 1)] )
    |> List.map ( \ (i,j) -> cell i j onPositions )


cell i j onPositions =
  div
    [ cellStyle i j onPositions
    , onClick (TogglePosition (i, j))
    ]
    []


cellStyle i j onPositions =
  style
    [ ("position", "absolute")
    , ("backgroundColor", "#fff")
    , ("width", (toString cellLength) ++ "px")
    , ("height", (toString cellLength) ++ "px")
    , ("left", (toString (j * (cellLength + 1))) ++ "px")
    , ("top", (toString (i * (cellLength + 1))) ++ "px")
    , ("backgroundImage", cellBackgroundImage i j onPositions)
    ]


cellBackgroundImage i j onPositions =
  if Set.member (i, j) onPositions then
    "url(" ++ imageUrl ++ ")"
  else
    ""
