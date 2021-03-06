module Data.Filter.Condition.LoanPurpose
    exposing
        ( LoanPurpose(..)
        , LoanPurposeCondition(..)
        , PurposeMsg
        , defaultLoanPurposeCondition
        , loanPurposeForm
        , renderLoanPurposeCondition
        , update
        , validationErrors
        )

import Bootstrap.Form.Checkbox as Checkbox
import Html exposing (Html, div)
import Util


type LoanPurpose
    = AUTO_MOTO
    | CESTOVANI
    | DOMACNOST
    | ELEKTRONIKA
    | REFINANCOVANI_PUJCEK
    | VLASTNI_PROJEKT
    | VZDELANI
    | ZDRAVI
    | JINE


allPurposes : List LoanPurpose
allPurposes =
    [ AUTO_MOTO, CESTOVANI, DOMACNOST, ELEKTRONIKA, REFINANCOVANI_PUJCEK, VLASTNI_PROJEKT, VZDELANI, ZDRAVI, JINE ]


type LoanPurposeCondition
    = LoanPurposeList (List LoanPurpose)


defaultLoanPurposeCondition : LoanPurposeCondition
defaultLoanPurposeCondition =
    LoanPurposeList []


loanPurposeToString : LoanPurpose -> String
loanPurposeToString loanPurpose =
    case loanPurpose of
        AUTO_MOTO ->
            "auto-moto"

        CESTOVANI ->
            "cestování"

        DOMACNOST ->
            "domácnost"

        ELEKTRONIKA ->
            "elektronika"

        REFINANCOVANI_PUJCEK ->
            "refinancování půjček"

        VLASTNI_PROJEKT ->
            "vlastní projekt"

        VZDELANI ->
            "vzdělání"

        ZDRAVI ->
            "zdraví"

        JINE ->
            "jiné"


renderLoanPurposeCondition : LoanPurposeCondition -> String
renderLoanPurposeCondition (LoanPurposeList list) =
    "účel je " ++ renderLoandPurposeList list


renderLoandPurposeList : List LoanPurpose -> String
renderLoandPurposeList =
    Util.orList loanPurposeToString


validationErrors : LoanPurposeCondition -> List String
validationErrors (LoanPurposeList rlist) =
    Util.validate (List.isEmpty rlist) "Účel úvěru: zvolte aspoň jeden"


type PurposeMsg
    = AddPurpose LoanPurpose
    | RemovePurpose LoanPurpose


update : PurposeMsg -> LoanPurposeCondition -> LoanPurposeCondition
update msg (LoanPurposeList plist) =
    case msg of
        AddPurpose p ->
            LoanPurposeList (p :: plist)

        RemovePurpose p ->
            LoanPurposeList (List.filter (\pu -> pu /= p) plist)


loanPurposeForm : LoanPurposeCondition -> Html PurposeMsg
loanPurposeForm (LoanPurposeList plist) =
    allPurposes
        |> List.map (\p -> loanPurposeCheckbox p (List.member p plist))
        |> div []


loanPurposeCheckbox : LoanPurpose -> Bool -> Html PurposeMsg
loanPurposeCheckbox purpose isEnabled =
    Checkbox.checkbox
        [ Checkbox.onCheck
            (\checked ->
                if checked then
                    AddPurpose purpose
                else
                    RemovePurpose purpose
            )
        , Checkbox.checked isEnabled
        , Checkbox.inline
        ]
        (loanPurposeToString purpose)
