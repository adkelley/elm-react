module Model where

--import Graphics.Element exposing ( show, Element )

type alias Entry =
  { catagory : String
  , price : String
  , stocked : Bool
  , name : String
  }
                 
type alias Entries = List Entry

type alias Model = Entries

newEntry : String -> String -> Bool -> String -> Entry
newEntry catagory price stocked name =
  { catagory = catagory
  , price = price
  , stocked = stocked
  , name = name
  }

initialModel : Model
initialModel =
  [ newEntry "Sporting Goods" "$49.99"  True  "Football"
  , newEntry "Sporting Goods" "$9.99"   True  "Baseball"
  , newEntry "Sporting Goods" "$29.99"  False "Basketball"
  , newEntry "Electronics"    "$99.99"  True  "iPod Touch"
  , newEntry "Electronics"    "$399.99" False "iPhone 5"
  , newEntry "Electronics"    "$199.99" True  "Nexus 7"
  ]

{-|
main : Element
main =
  show initialModel
-}
