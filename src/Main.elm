module Main exposing (..)

import Browser exposing (sandbox)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


type alias Todo =
    { id : Int
    , title : String
    , completed : Bool
    }


type alias Model =
    { todos : List Todo
    , id : Int
    , title : String
    }


initialModel : Model
initialModel =
    { todos = []
    , id = 0
    , title = ""
    }


newTodoItem : String -> Int -> Todo
newTodoItem title id =
    { title = title
    , id = id
    , completed = Basics.False
    }



-- UPDATE


type Msg
    = AddTodoItem


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodoItem ->
            { model
                | id = model.id + 1
                , title = ""
                , todos =
                    if String.isEmpty model.title then
                        model.todos

                    else
                        model.todos ++ [ newTodoItem model.title model.id ]
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ viewAddTodoInput
            , viewTodoList model.todos
            ]
        ]


viewAddTodoInput : Html Msg
viewAddTodoInput =
    div []
        [ input [ placeholder "title" ] []
        , button [ onClick AddTodoItem ] [ text "add item" ]
        ]



-- VIEW TODOS


viewTodoList : List Todo -> Html Msg
viewTodoList todos =
    let
        todoList =
            List.map viewTodoItem todos
    in
    ul [] todoList


viewTodoItem : Todo -> Html Msg
viewTodoItem todo =
    li []
        [ span [] [ text todo.title ] ]



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }
