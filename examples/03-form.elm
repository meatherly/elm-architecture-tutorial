import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String exposing (length)
import Debug exposing (log)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  , valid : Bool
  }


model : Model
model =
  Model "" "" "" "" True



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Validate


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      log "changed"
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }

    Validate ->
      log "called"
      { model | valid = validateModel model }




-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , input [ type' "submit", onClick Validate ] [ text "Submit"]
    , viewValidation model
    ]

validateModel : Model -> Bool
validateModel model =
  model.password == model.passwordAgain && length model.password > 8

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.valid then
        ("green", "")
      else
        ("red", "Error")
  in
    div [ style [("color", color)] ] [ text message ]
