module Model where

type alias Product =
  { category : String
  , price : String
  , stocked : Bool
  , name : String
  }
                 
type alias Products = List Product

newProduct : String -> String -> Bool -> String -> Product
newProduct category price stocked name =
  { category = category
  , price = price
  , stocked = stocked
  , name = name
  }

initialModel : Products
initialModel =
  [ newProduct "Sporting Goods" "$49.99"  True  "Football"
  , newProduct "Sporting Goods" "$9.99"   True  "Baseball"
  , newProduct "Sporting Goods" "$29.99"  False "Basketball"
  , newProduct "Electronics"    "$99.99"  True  "iPod Touch"
  , newProduct "Electronics"    "$399.99" False "iPhone 5"
  , newProduct "Electronics"    "$199.99" True  "Nexus 7"
  ]

