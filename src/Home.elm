module Home exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program (Maybe Profile) Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- INIT


type alias Profile =
    { github : String
    , twitter : String
    }


type alias Model =
    { profile : Profile
    , navbarVisible : Bool
    }


init : Maybe Profile -> ( Model, Cmd Msg )
init maybeProfile =
    ( { profile = loadProfile maybeProfile
      , navbarVisible = False
      }
    , Cmd.none
    )


loadProfile : Maybe Profile -> Profile
loadProfile =
    Maybe.withDefault
        { github = ""
        , twitter = ""
        }



-- UPDATE


type Msg
    = NoOp
    | ToggleNavbar


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ToggleNavbar ->
            ( { model | navbarVisible = not model.navbarVisible }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ viewNavbar model
        , viewSocialLinks model
        , viewIntro
        , viewFooter
        ]


viewIntro : Html Msg
viewIntro =
    section
        [ class "hero is-white is-medium" ]
        [ container
            ( div, "hero-body" )
            []
            [ h1 [ class "title" ] [ text "Greetings!" ]
            , p
                [ class "subtitle" ]
                [ text "My name is Hideyuki Ueno."
                , br [] []
                , text "I'm making websites, (mostly) web based programs."
                ]
            ]
        ]


viewNavbar : Model -> Html Msg
viewNavbar { navbarVisible } =
    let
        navbarActive =
            if navbarVisible then
                [ class "is-active" ]

            else
                []

        navbarItem display =
            a [ class "navbar-item" ] [ text display ]

        navbarMenu =
            div
                (class "navbar-menu" :: navbarActive)
                [ wrapper "navbar-end" <|
                    [ navbarItem "About"
                    , navbarItem "Project"
                    , navbarItem "Blog"
                    ]
                ]

        navbarBurger =
            a
                ([ class "navbar-burger", onClick ToggleNavbar ] ++ navbarActive)
                (List.repeat 3 (span [] []))
    in
    nav
        [ class "navbar is-white" ]
        [ wrapper "container" <|
            [ wrapper "navbar-brand" <|
                [ div
                    [ class "navbar-item" ]
                    [ span
                        [ class "is-size-5" ]
                        [ text "lettenj61" ]
                    ]
                , navbarBurger
                ]
            , navbarMenu
            ]
        ]


viewSocialLinks : Model -> Html msg
viewSocialLinks { profile } =
    let
        makeLink path wrapperClass iconClass desc =
            a
                [ class <| "button is-rounded " ++ wrapperClass
                , href path
                , target "_blank"
                , rel "noopener"
                , title desc
                ]
                [ span
                    [ class <| "icon is-medium" ]
                    [ i [ class iconClass ] []
                    ]
                ]

        twitterLink =
            "https://twitter.com/" ++ profile.twitter

        githubLink =
            "https://github.com/" ++ profile.github
        
        scrapboxLink =
            "https://scrapbox.io/" ++ profile.github

        socialLinks =
            [ makeLink twitterLink "is-info" "fab fa-lg fa-twitter" ("Follow @" ++ profile.twitter)
            , makeLink githubLink "is-dark" "fab fa-lg fa-github-alt" "GitHub activity"
            , makeLink scrapboxLink "is-success" "fas fa-lg fa-pencil-ruler" "Scrapbox notes"
            ]
    in
    container ( section, "section" ) [] <|
        [ div
            [ class "buttons is-centered" ]
            socialLinks
        ]


viewFooter : Html msg
viewFooter =
    container
        ( footer, "footer" )
        [ class "has-text-centered" ]
        [ p
            []
            [ text "2019 @lettenj61. Powered by "
            , a [] [ text "Elm" ]
            , text ", "
            , a [] [ text "Hugo" ]
            , text ", "
            , a [] [ text "Bulma" ]
            , text ", and 💖"
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UTILITY


type alias Tagger msg =
    List (Attribute msg) -> List (Html msg) -> Html msg


container : ( Tagger msg, String ) -> List (Attribute msg) -> List (Html msg) -> Html msg
container ( tagger, wrapperClass ) attrs children =
    tagger
        [ class wrapperClass ]
        [ div
            ( class "container" :: attrs )
            children
        ]


wrapper : String -> List (Html msg) -> Html msg
wrapper className children =
    div [ class className ] children


flexColumn : List (Attribute msg) -> List (Html msg) -> Html msg
flexColumn attrs children =
    div
        ( class "column"  :: attrs )
        children
