module Main exposing (..)

import Html exposing (..)
import Json.Decode as JD exposing (..)
import Platform.Sub
import Phoenix
import Phoenix.Channel as Channel exposing (Channel)
import Phoenix.Socket as Socket exposing (Socket)


type alias Model =
    {}


type Msg
    = ReceivedInt JD.Value
    | ReceivedString JD.Value


intDecoder : Decoder Int
intDecoder =
    at [ "msg" ] int


stringDecoder : Decoder String
stringDecoder =
    at [ "msg" ] string


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceivedInt raw ->
            case JD.decodeValue intDecoder raw of
                Ok myInt ->
                    let
                        _ =
                            Debug.log "int received" myInt
                    in
                        model ! []

                Err error ->
                    Debug.log error
                        model
                        ! []

        ReceivedString raw ->
            case JD.decodeValue stringDecoder raw of
                Ok myString ->
                    let
                        _ =
                            Debug.log "string received" myString
                    in
                        model ! []

                Err error ->
                    Debug.log error
                        model
                        ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Platform.Sub.batch
        [ Phoenix.connect fooSocket [ intChannel ]
        , Phoenix.connect barSocket [ stringChannel ]
        ]


fooSocket : Socket Msg
fooSocket =
    Socket.init "ws://localhost:4000/foo/websocket"
        |> Socket.withDebug



-- |> Socket.withDebug


barSocket : Socket Msg
barSocket =
    Socket.init "ws://localhost:4000/bar/websocket"
        |> Socket.withDebug



-- |> Socket.withDebug


intChannel : Channel Msg
intChannel =
    Channel.init "ints"
        |> Channel.onJoin ReceivedInt
        |> Channel.on "update" ReceivedInt
        |> Channel.withDebug


stringChannel : Channel Msg
stringChannel =
    Channel.init "strings"
        |> Channel.onJoin ReceivedString
        |> Channel.on "update" ReceivedString
        |> Channel.withDebug


view : Model -> Html Msg
view model =
    div [] [ text "open the console to view the messages" ]
