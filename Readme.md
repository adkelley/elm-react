## Taking React patterns and implementing them Elm
I'm going to take you through my thought process of creating a searchable product data table in Elm. The thought process of building this table in
React using JSX and Javascript was described in Pete Hunt's seminal [blog post](https://facebook.github.io/react/docs/thinking-in-react.html).
But instead of React, I'm using Elm while adhering to the same variable and components names from Pete's original blog post.
My goal is that It'll help others to learn how to deconstruct patterns in React and convert them to pure functional patterns in Elm.

## Step 0: Model the data
Our JSON API returns some data that looks like this:

```json
[
  {category: "Sporting Goods", price: "$49.99", stocked: true, name: "Football"},
  {category: "Sporting Goods", price: "$9.99", stocked: true, name: "Baseball"},
  {category: "Sporting Goods", price: "$29.99", stocked: false, name: "Basketball"},
  {category: "Electronics", price: "$99.99", stocked: true, name: "iPod Touch"},
  {category: "Electronics", price: "$399.99", stocked: false, name: "iPhone 5"},
  {category: "Electronics", price: "$199.99", stocked: true, name: "Nexus 7"}
];
```

In Elm, we model it like this:
```elm
newProduct : String -> String -> Bool -> String -> Product
newProduct category price stocked name =
  { category = category
  , price = price
  , stocked = stocked
  , name = name
  }

initialModel : Model
initialModel =
  [ newProduct "Sporting Goods" "$49.99"  True  "Football"
  , newProduct "Sporting Goods" "$9.99"   True  "Baseball"
  , newProduct "Sporting Goods" "$29.99"  False "Basketball"
  , newProduct "Electronics"    "$99.99"  True  "iPod Touch"
  , newProduct "Electronics"    "$399.99" False "iPhone 5"
  , newProduct "Electronics"    "$199.99" True  "Nexus 7"
  ]
```

## Step 1: Break the UI into a component hierachy
Following the same approach React, I broke down the mock into five components

- FilterableProductTable
  - SearchBar
  - ProductTable
    - ProductCategoryRow
    - ProductRow


