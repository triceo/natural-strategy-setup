module View.InvestmentShare exposing (form)

import Data.InvestmentShare exposing (InvestmentShare(..))
import Html exposing (Html, div, fieldset, input, label, legend, text)
import Html.Attributes as Attr exposing (checked, disabled, name, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Types exposing (..)


form : InvestmentShare -> Html Msg
form investmentShare =
    let
        ( isUnrestricted, validationError, valueAttribute ) =
            case investmentShare of
                Unrestricted ->
                    ( True, [], value defaultValue )

                PercentShare pct ->
                    let
                        validationError =
                            if pct < 1 || 100 < pct then
                                [ div [ style [ ( "color", "red" ) ] ] [ text "Podíl výše úvěru musí být mezi 1 a 100 %" ] ]
                            else
                                []
                    in
                    ( False, validationError, value (toString pct) )
    in
    fieldset [] <|
        [ legend []
            [ text "Maximální podíl ivestice" ]
        , text "Investovat  "
        , div []
            [ label []
                [ input [ type_ "radio", name "portfolioShare", onClick (TargetPortfolioShareChanged "undefined"), checked isUnrestricted ] []
                , text " bez ohledu na to jaký podíl výše úvěru moje půjčka pokryje"
                ]
            ]
        , label []
            [ input [ type_ "radio", name "portfolioShare", onClick (TargetPortfolioShareChanged defaultValue), checked (not isUnrestricted) ] []
            , text " maximalně "
            , input [ type_ "number", Attr.min "1", Attr.max "100", onInput TargetPortfolioShareChanged, disabled isUnrestricted, valueAttribute ] []
            , text " % výše úvěru."
            ]
        ]
            ++ validationError


defaultValue : String
defaultValue =
    "1"
