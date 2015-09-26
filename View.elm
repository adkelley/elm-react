module View where

import Model exposing ( Products, Product, model)
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Html.Events exposing ( on, targetChecked, targetValue )
import Signal exposing ( Address, Mailbox )
import String exposing ( contains )

-- STATE

type alias State =
  { inStockOnly : Bool
  , filterText : String
  }

initialState : State
initialState =
  { inStockOnly = False
  , filterText = ""
  }


-- UPDATE

type Action
  = FilterText String
  | InStockOnly Bool
  | NoOp


update : Action -> State -> State
update action state =
  case action of
    NoOp ->
      state

    InStockOnly bool ->
      { state |  inStockOnly <- bool }
      
    FilterText string ->
      { state | filterText <- string }
  
-- VIEW

productCategoryRow : String -> Html
productCategoryRow category =
  tr
    [ ]
    [ th [ align "left", colspan 2 ] [ text category ] ]



productRow : Product -> Html
productRow product =
  let stockedStyle =
        if product.stocked
        then style [ ( "color", "black" ) ]
        else style [ ( "color", "red" ) ]
  in
    tr
    [ ]
    [ td [ stockedStyle ] [ text product.name ]
    , td [ ] [ text product.price ]
    ]

 
type alias Components = List Html

productTable : Products -> State -> Html
productTable products state =
  let
    rows : String -> Products -> Components -> Components
    rows lastCategory products' components =
      case List.head products' of
        Just product ->
          if product.category /= lastCategory
          then rows product.category products'  ( ( productCategoryRow product.category ) :: components  )
          else
            if ( not <| String.contains state.filterText product.name ) || ( state.inStockOnly && ( not product.stocked ) )
            then rows product.category ( List.drop 1 products' ) components
            else rows product.category ( List.drop 1 products' ) ( ( productRow product ) :: components )

        otherwise ->
          List.reverse components
  in
    table
    [ ]
    [ thead 
      [ ]
      [ tr
        [ ]
        [ th [ align "left"] [ text "Name" ]
        , th [ align "left"] [ text "Price" ]
        ]
      ]
    , tbody
      [ ]
      ( rows "" products [ ] )
    ]



searchBar : Signal.Address Action -> State -> Html
searchBar address state =
  Html.form 
    [ ]
    [ input
      [ type' "text"
      , value state.filterText
      , on "input" targetValue ( Signal.message address << FilterText )
      , placeholder "Search ..."
      ]
      [ ]
    , p
      [ ]
      [ input
        [ type' "checkbox"
        , checked state.inStockOnly
        , on "change" targetChecked ( Signal.message address << InStockOnly )
        ]
        [ ]
      , text "Only show products in stock"
      ]
    ]


filterableProductTable : Signal.Address Action -> Products -> State -> Html
filterableProductTable address products state =
  div
  [ class "FilterableProductTable" ]
  [ searchBar address state
  , productTable products state
  ]


-- SIGNALS

inbox : Signal.Mailbox Action
inbox =
  Signal.mailbox NoOp


actions : Signal Action
actions =
  inbox.signal 


state : Signal State
state =
  Signal.foldp update initialState actions


main : Signal Html
main =
  Signal.map (filterableProductTable inbox.address model) state

