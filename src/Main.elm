module Main exposing (..)

import Browser exposing (sandbox)
import Debug
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



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
    { todos = [ { id = 1, title = "todo thing", completed = False } ]
    , id = 0
    , title = ""
    }


newTodoItem : String -> Int -> Todo
newTodoItem title id =
    { title = title
    , id = id
    , completed = False
    }


deleteTodo : List Todo -> Int -> List Todo
deleteTodo todos id =
    List.filter (\x -> x.id /= id) todos


completeTodoItem : List Todo -> Int -> List Todo
completeTodoItem todos id =
    List.map
        (\todo ->
            if todo.id == id then
                { todo | completed = not todo.completed }

            else
                todo
        )
        todos



-- (a -> b) -> List a -> List b
-- getTodoTitle :  : List Todo -> Int -> String
-- getTodoTitle todos id =
--     todos
--         |> List.filter (\x -> x.id == id)
-- UPDATE


type Msg
    = AddTodoItem
    | UpdateTitle String
    | DeleteTodoItem Int
    | CompleteTodoItem Int



-- | EditTodoItem Int


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

        UpdateTitle value ->
            { model | title = value }

        DeleteTodoItem id ->
            { model | todos = deleteTodo model.todos id }

        CompleteTodoItem id ->
            { model | todos = completeTodoItem model.todos id }



-- EditTodoItem id ->
--     { model | title = getTodoTitle model.todos id }
-- VIEW


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ viewHero
        , viewAddTodoInput model.title
        , viewTodoList model.todos
        , viewCompletedTodoList model.todos
        ]


viewHero : Html Msg
viewHero =
    div [ class "hero" ] [ text "A Todo List Built In Elm" ]


viewAddTodoInput : String -> Html Msg
viewAddTodoInput title =
    div [ class "item-group" ]
        [ div [ class "item-title" ] [ text "Add a todo item" ]
        , input
            [ value title
            , onInput UpdateTitle
            , placeholder "Build more apps in Elm"
            , class "item-input"
            ]
            []
        , button [ onClick AddTodoItem, class "item-button" ] [ text "add item" ]
        ]



-- VIEW TODOS


viewTodoList : List Todo -> Html Msg
viewTodoList todos =
    let
        todoList =
            List.map viewTodoItem todos
    in
    div [ class "item-group" ]
        [ div [ class "item-title" ] [ text "Things to do" ]
        , ul [ class "todo-item-group" ] todoList
        ]


viewTodoItem : Todo -> Html Msg
viewTodoItem todo =
    if todo.completed == False then
        li [ class "todo-item" ]
            [ span [ class "todo-item-title" ]
                [ text todo.title ]
            , div []
                [ button
                    [ class "todo-item-button"

                    -- , onClick (EditTodoItem todo.id)
                    ]
                    [ text "edit" ]
                , button
                    [ class "todo-item-button"
                    , onClick (DeleteTodoItem todo.id)
                    ]
                    [ text "delete" ]
                , button
                    [ class "todo-item-button"
                    , onClick (CompleteTodoItem todo.id)
                    ]
                    [ text "complete" ]
                ]
            ]

    else
        text ""


viewCompletedTodoList : List Todo -> Html Msg
viewCompletedTodoList todos =
    let
        todoList =
            List.map viewCompletedTodos todos
    in
    div [ class "item-group" ]
        [ div [ class "item-title" ] [ text "Completed items" ]
        , ul [ class "todo-item-group" ] todoList
        ]


viewCompletedTodos todo =
    if todo.completed == True then
        li [ class "todo-item" ]
            [ span [ class "todo-item-title" ]
                [ text todo.title ]
            , div []
                [ button
                    [ class "todo-item-button"
                    , onClick (DeleteTodoItem todo.id)
                    ]
                    [ text "delete" ]
                ]
            ]

    else
        text ""



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }
