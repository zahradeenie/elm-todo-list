module Main exposing (..)

import Browser exposing (sandbox)
import Html as H
import Html.Attributes as HA
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> H.Html Msg
view model =
    H.div []
        [ H.button [ onClick Decrement ] [ H.text "-" ]
        , H.div [] [ H.text (String.fromInt model) ]
        , H.button [ onClick Increment ] [ H.text "+" ]
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }
