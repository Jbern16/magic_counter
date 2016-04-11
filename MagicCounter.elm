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
    creatures : List
    nextID : Int
  }

type alias Creature =
  { name : String,
    health : Int,
    attacl : Int,
    id: Int
  }

initialModel : Model
initialModel =
  {
    player1 =  20,
    player2 =  20,
    creatures = []
    nextID = 1
  }

newCreature name health attack id =
  {
    name = name
    health = health
    attack = attack
    id = id
  }

-- UPDATE

type Action
  = NoOp
  | Increment1
  | Increment2
  | Decrement1
  | Decrement2
  | AddCreature
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
    AddCreature ->

    Reset ->
      { model | player1 = 20, player2 = 20 }


-- VIEW

creatureList address creature =
    li [ classList [  ],
         onClick address (Mark entry.id)
        ]
      [ span [ ] [ text creature.name ]
      [ span [ class "Health" ] [ text creature.health ],
        span [ class "Attack" ] [ text creature.attack ],
        button
          [ class "Delete", onClick address (Delete creature.id) ]
          [ ]
      ]

view : Address Action -> Model -> Html
view address model =
  div [ class "container" ] [
    div [ class "row" ] [
      div [ class "large-6 columns" ]
      [
        h3 [ class "subheader" ] [ text "Player 1 Health" ],
        button [ class "success hollow button", onClick address Increment1 ] [ text "+" ],
        h2 [ ] [ text (toString model.player1) ],
        button [ class "alert hollow button", onClick address Decrement1 ] [ text "-" ]

      ],
      div [ class "large-6 columns" ]
      [
      h3 [ class "subheader" ] [ text "Player 2 Health" ],
        button [ class "success hollow button", onClick address Increment2 ] [ text "+" ],
        h2 [  ] [ text (toString model.player2) ],
        button [ class "alert hollow button", onClick address Decrement2 ] [ text "-" ]
      ]
      ],
    div [ class "row" ] [
      div [ class "large-12 large-offset-3 columns" ]
      [
        button [ class "warning hollow button", onClick address Reset ] [ text "reset" ]
      ] ] ]
    div [ class "row" ] [
      div [ class "large-12 large-offset-3 columns" ]
      [
        button [ class "warning hollow button", onClick address AddCreature ] [ text "reset" ]
      ] ] ]



main: Signal Html
main =
  StartApp.start
    {
      model = initialModel,
      view = view,
      update = update
    }
