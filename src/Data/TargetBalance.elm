module Data.TargetBalance
    exposing
        ( TargetBalance(..)
        , defaultTargetBalance
        , renderTargetBalance
        )


type TargetBalance
    = NotSpecified
    | TargetBalance Int


defaultTargetBalance : TargetBalance
defaultTargetBalance =
    TargetBalance 200


renderTargetBalance : TargetBalance -> String
renderTargetBalance targetBalance =
    case targetBalance of
        TargetBalance balance ->
            "Investovat pouze pokud disponibilní zůstatek přesáhne " ++ toString balance ++ " Kč."

        NotSpecified ->
            ""
