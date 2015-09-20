module Model where

type alias ProductRow =
  { catagory : String
  , price : String
  , stocked : Bool
  , name : String
  }
                 
type alias ProductRows = List ProductRow

type alias Model = ProductRows

newProductRow : String -> String -> Bool -> String -> ProductRow
newProductRow catagory price stocked name =
  { catagory = catagory
  , price = price
  , stocked = stocked
  , name = name
  }

initialModel : Model
initialModel =
  [ newProductRow "Sporting Goods" "$49.99"  True  "Football"
  , newProductRow "Sporting Goods" "$9.99"   True  "Baseball"
  , newProductRow "Sporting Goods" "$29.99"  False "Basketball"
  , newProductRow "Electronics"    "$99.99"  True  "iPod Touch"
  , newProductRow "Electronics"    "$399.99" False "iPhone 5"
  , newProductRow "Electronics"    "$199.99" True  "Nexus 7"
  ]

