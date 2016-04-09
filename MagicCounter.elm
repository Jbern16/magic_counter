import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp.Simple as StartApp

-- MODEL

type alias Model =
  {
    player1 : Int,
    player2 : Int
  }

initialModel : Model
initialModel =
  {
    player1 =  20,
    player2 =  20
  }

-- UPDATE

type Action
  = NoOp
  | Increment1
  | Increment2
  | Decrement1
  | Decrement2
  | Reset


update action model =
  case action of
    NoOp ->
      model
    Increment1 ->
      { model | player1 = model.player1 + 1 }
    Increment2 ->
      { model | player2 = model.player2 + 1 }
    Decrement1 ->
      { model | player1 = model.player1 - 1 }
    Decrement2 ->
      { model | player2 = model.player2 - 1 }
    Reset ->
      { model | player1 = 20, player2 = 20 }


-- VIEW

view address model =
  div [ class "container" ] [
    div [ class "row" ] [
    h3 [ ] [ text "Player 1 Health" ],
      div [ class "col-xs-8 col-offset-xs-2" ]
      [
        button [ class "btn btn-primary", onClick address Increment1 ] [ text "+" ],
        div [ ] [ text (toString model.player1) ],
        button [ class "btn btn-primary", onClick address Decrement1 ] [ text "-" ]

      ]
    ],
    div [ class "row" ] [
    h3 [ ] [ text "Player 1 Health" ],
      div [ class "col-xs-10 col-offset-xs-1" ]
      [
        button [ class "btn btn-primary", onClick address Increment2 ] [ text "+" ],
        div [ ] [ text (toString model.player2) ],
        button [ class "btn btn-primary", onClick address Decrement2 ] [ text "-" ]

      ]
    ],
    div [ class "row" ] [
      div [ class "col-xs-10 col-offset-xs-1" ]
      [
        button [ class "btn btn-primary", onClick address Reset ] [ text "reset" ]
      ] ] ]


main =
  StartApp.start
    {
      model = initialModel,
      view = view,
      update = update
    }
