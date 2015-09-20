## Thinking in React, Implementing in Elm
Go through process of creating a webapp in React described in this [blog post](https://facebook.github.io/react/docs/thinking-in-react.html).
But instead of using Javascript and JSX, I'm using the Elm language.

## Step 0: Model the data
Our JSON API returns some data that looks like this:

``
initialModel : Model
initialModel =
  [ newEntry "Sporting Goods" "$49.99"  True  "Football"
  , newEntry "Sporting Goods" "$9.99"   True  "Baseball"
  , newEntry "Sporting Goods" "$29.99"  False "Basketball"
  , newEntry "Electronics"    "$99.99"  True  "iPod Touch"
  , newEntry "Electronics"    "$399.99" False "iPhone 5"
  , newEntry "Electronics"    "$199.99" True  "Nexus 7"
  ]
``

## Step 1: Break the UI into a componenent hierachy
- FilterableProductTable
  - SearchBar
  - ProductTable
    - ProductCategoryRow
    - ProductRow


