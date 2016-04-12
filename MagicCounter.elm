module MagicCounter where


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing(Address)
import StartApp.Simple as StartApp
import String exposing(toInt)

-- MODEL

type alias Model =
  {
    player1 : Int,
    player2 : Int,
    creatures : List,
    creatureNameInput : String,
    healthInput : String,
    attackInput : String,
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
    creatures = [],
    creatureNameInput = "",
    healthInput = "",
    attackInput = "",
    nextID = 1
  }

newCreature name health attack id =
  {
    name = name,
    health = health,
    attack = attack,
    id = id
  }

-- UPDATE

type Action
  = NoOp
  | Increment1
  | Increment2
  | Decrement1
  | Decrement2
  | UpdateCreatureName String
  | UpdateCreatureHealth String
  | UpdateCreatureAttack String
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
    UpdateCreatureName contents ->
      { model | creatureNameInput = contents }
    UpdateCreatureHealth contents ->
      { model | healthInput = contents }
    UpdateCreatureAttack contents ->
      { model | attackInput = contents }
    AddCreature ->
      let
        creature = newCreature model.creatureNameInput (parseInt model.healthInput) (parseInt model.attackInput) model.id
      in
        { model |
          creatureNameInput = "",
          healthInput = "",
          attackInput = "",
          creatures = creature :: model.creatures,
          nextID = model.nextID + 1
        }
    Reset ->
      { model | player1 = 20, player2 = 20 }


-- VIEW

parseInt : String -> Int
parseInt string =
  case String.toInt string of
    Ok value ->
      value
    Err error ->
      0

onInput : Address a -> (String -> a) -> Attribute
onInput address f =
  on "input" targetValue (\v -> Signal.message address (f v))


creatureList address creature =
      div [] [
       span [ ] [ text creature.name ],
       span [ class "Health" ] [ text creature.health ],
       span [ class "Attack" ] [ text creature.attack ]
      ]

newCreatureForm : Address Action -> Model -> Html
newCreatureForm address model =
  h4
   [ ]
   [ text (model.creatureNameInput) ]
  div [ ]
    [ input
        [ type' "text",
          value model.creatureNameInput,
          name "name",
          onInput address UpdateCreatureName
          ]
          [ ],
      input
        [ type' "number",
          value.model.healthInput,
          name "health",
          onInput address UpdateCreatureHealth
          ]
        [ ],
      input
        [ type' "number",
          value.model.attackInput,
          name "attack",
          onInput address UpdateCreatureAttack
          ]
        [ ],
      button
        [ class "success hollow button",
          onClick address AddCreature
        ] [ text "Add Creature" ]
      ]

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
      [ button [ class "warning hollow button", onClick address Reset ] [ text "reset" ]
      ] ]

view : Address Action -> Model -> Html
view address model =
    div [ class "container" ] [
        player1Health address model,
        player2Health address model,
        reset address model,
        newCreatureForm address model,
        creatureList address model
       ]

main: Signal Html
main =
  StartApp.start
    {
      model = initialModel,
      view = view,
      update = update
    }
