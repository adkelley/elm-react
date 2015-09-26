# Draft Blog Post

## Thinking in React, implementing in Elm
I'm going to take you through my thought process of creating a searchable product data table in Elm. The inspiration for this example came from
some discussion on the Elm Groups forum xx in which a poster was attempting to go from React to Elm.
React using JSX and Javascript was described in Pete Hunt's seminal [blog post](https://facebook.github.io/react/docs/thinking-in-react.html).
But instead of React, I'm using Elm while adhering to the same variable and components names from Pete's original blog post.
My goal is to help others learn how to deconstruct patterns in React and convert them to pure functional patterns in Elm. I suggest you
first implement the data table in React, because it will help you to clearly understand how to translate a pattern from React into Elm.

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

In Elm, we model it like the code shown below, and we put it in a module call Model.
We will import this module in our View module coming up in Step 2

```elm
newProduct : String -> String -> Bool -> String -> Products
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
```

## Step 1: Break the UI into a component hierachy
Following the same approach in the original blog post, we break down the
mock into five components

- FilterableProductTable
  - SearchBar
  - ProductTable
    - ProductCategoryRow
    - ProductRow

## Step 2: Build the static version in React
Next we build a version that takes the data model and renders the UI but has no interactivity.  Please refer to View.elm for the source, but the the most tricking part of code below.  The challenge was to render a Product Catagory Row and a Product Row whenever we encountered a new product category.
This is easily done imperatively because I simply mutate the lastCatagory variable.
Go back and review the imperative implementation given in Pete's blog post.  It took awhile but it finally dawned on me that the best approach was to declare a recursive function that would only send the tail of the model when there was more of the same product categories in the list.  Whenever encountered a new category I would call the function without xx.  I also avoided xx


### A brief interlude: props vs state
Do I need to touch on this?

## Step 3: Identify the minimal (but complete) representation of UI state 
The same rules you apply in React to determine state are the same in Elm.  Simply ask three questions about each piece of data:
1. Is it passed in from a parent via props? If so, it probably isn't state.
2. Does it change over time? If not, it probably isn't state.
3. Can you compute it based on any other state or props in your component? If so, it's not state.

So finally, our state is:
- The search text the user has entered
- The value of the checkbox

## Step 4: Identify where your state should live

