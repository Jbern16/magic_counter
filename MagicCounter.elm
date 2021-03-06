module MagicCounter where


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing(Address)
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

update : Action -> Model -> Model
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


player1Health address model =
    div [ class "row" ] [
      div [ class "large-6 columns" ]
      [
        h3 [ class "subheader" ] [ text "Player 1 Health" ],
        button [ class "success hollow button", onClick address Increment1 ] [ text "+" ],
        h2 [ ] [ text (toString model.player1) ],
        button [ class "alert hollow button", onClick address Decrement1 ] [ text "-" ]
      ] ]

player2Health address model =
    div [ class "large-6 columns" ]
    [
    h3 [ class "subheader" ] [ text "Player 2 Health" ],
      button [ class "success hollow button", onClick address Increment2 ] [ text "+" ],
      h2 [  ] [ text (toString model.player2) ],
      button [ class "alert hollow button", onClick address Decrement2 ] [ text "-" ]
    ]

reset address model =
    div [ class "row" ] [
      div [ class "large-12 large-offset-3 columns" ]
      [
        button [ class "warning hollow button", onClick address Reset ] [ text "reset" ]
      ] ]

view : Address Action -> Model -> Html
view address model =
    div [ class "container" ] [
        player1Health address model,
        player2Health address model,
        reset address model
       ]

main: Signal Html
main =
  StartApp.start
    {
      model = initialModel,
      view = view,
      update = update
    }
