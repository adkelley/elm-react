module View where

import Model exposing ( Model, initialModel, Product )
import Graphics.Element exposing ( show, Element )
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Debug exposing ( .. )


productCategoryRow : String -> Html
productCategoryRow category =
  tr
    [ ]
    [ th [ colspan 2 ] [ text category ] ]



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

productTable : Model -> Html
productTable model =
  let
    rows : String -> Model -> Components -> Components
    rows lastCategory model' components =
      case List.head model' of
        Just product ->
          if product.category /= lastCategory
          then rows product.category model'  ( ( productCategoryRow product.category ) :: components  )
          else rows product.category ( List.drop 1 model' ) ( ( productRow product ) :: components )
        otherwise ->
          List.reverse components
  in
    table
    [ ]
    [ thead 
      [ ]
      [ tr
        [ ]
        [ th [ ] [ text "Name" ]
        , th [ ] [ text "Price" ]
        ]
      ]
    , tbody
      [ ]
      ( rows "" model [ ] )
  ]



searchBar : Html
searchBar =
  Html.form 
    [ ]
    [ input [ type' "text", placeholder "Search ..." ] [ ]
    , p
      [ ]
      [ input [ type' "checkbox" ] [ ]
      , text "Only show products in stock"
      ]
    ]


filterableProductTable : Model -> Html
filterableProductTable model =
  div
   [ class "FilterableProductTable" ]
   [ searchBar
   , productTable model
   ]


view : Model -> Html
view model =
    filterableProductTable model


main : Html
main =
  view initialModel
