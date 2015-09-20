module View where

import Model exposing ( Model, initialModel, ProductRow )
import Graphics.Element exposing ( show, Element )
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Debug exposing ( .. )

productCategoryRow : String -> Html
productCategoryRow category =
  tr
    [ ]
    [ th [ colspan 2 ] [ text category ] ]



productRow : ProductRow -> Html
productRow row =
  Debug.crash ( "productRow: not implemented yet" )


productTable : Model -> Html
productTable model =
  table
    [ ]
    [ thead
        [ ]
        [ tr
          [ ]
          [ th [ ] [text "Name"]
          , th [ ] [ text "Price"]
          ]
        ]
    , tbody
      [ ]
      [ text "Table Body" ]
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
