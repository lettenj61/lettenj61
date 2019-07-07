module Home exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { field : Maybe String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { field = Nothing }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view _ =
    viewHomepage


viewHomepage : Html msg
viewHomepage =
    section
        [ class "hero is-white" ]
        [ wrapper "hero-head" [ viewNavbar ]
        , wrapper "hero-body" [ viewIntro ]
        , wrapper "hero-foot" [ viewBottomMenu ]
        ]


viewNavbar : Html msg
viewNavbar =
    nav
        [ class "navbar" ]
        [ wrapper "container" <|
            [ wrapper "navbar-brand" <|
                [ a
                    [ class "navbar-item" ]
                    [ span
                        [ class "is-size-5" ]
                        [ text "lettenj61" ]
                    ]
                , a
                    [ class "navbar-burger burger" ]
                    (List.repeat 3 (span [] []))
                ]
            ]
        ]


viewIntro : Html msg
viewIntro =
    wrapper "container has-text-centered" <|
        [ span
            [ class "icon is-large" ]
            [ i
                [ class "fas fa-4x fa-pastafarianism" ]
                []
            ]
        , h1 [ class "title" ] [ text "Greetings!" ]
        , p
            [ class "subtitle" ]
            [ text "My name is Hideyuki Ueno."
            , br [] []
            , text "I'm making websites, (mostly) web based programs."
            ]
        ]


viewBottomMenu : Html msg
viewBottomMenu =
    let
        tab display =
            li
                []
                [ a [] [ text display ]
                ]
    in
    nav
        [ class "tabs" ]
        [ wrapper "container" <|
            [ ul
                []
                [ tab "Coming soon" ]
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UTILITY


wrapper : String -> List (Html msg) -> Html msg
wrapper className children =
    div [ class className ] children
