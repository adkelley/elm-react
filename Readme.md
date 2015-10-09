# Tutorial: Thinking in Elm

I'm going to take you through my thought process of creating a searchable product data table using the [Elm](http://elm-lang.org/) functional reactive programming language.
My inspiration and outline for this tutorial came from Pete Hunt's blog post ['Thinking in React'](https://facebook.github.io/react/docs/thinking-in-react.html). 
Pete shows how the React framework makes you think about apps as you build them, and what I found is that Elm shares this same characteristic.
Moreover, as I was going through the steps that Pete outlines for creating the product table, I found that with few exceptions I can use the very same steps.
So I'm going to take you through

In fact, both Elm and React share a lot more similarities than just helping you to write well architected code.
Here's a few important ones that I've observed:
1) Both are based on Functional-Reactive principles. However I would argue that in React FRP is a paradigm, whereas Elm is the real deal;
2) They are intended to help build front end applications that use data that changes over time;
3) Data is unidirectional, from the parent component down to the child componenent(s).
4) Components are composable. In React they're considered classes, but in Elm they're actually pure functions.
5) React and Elm both maintain a virtual DOM of their own, making them render super fast.

But naturally, Elm is also very different than React.  Besides writing in a different language than Javascript and JSX, Elm is purely
functional and therefore you must think and implement functionally in order to implement a UI. This isn't hard, especially if you haven't spent
a lot of time writing imperative code.  While React espouses functional style programming, after all its Javascript and therefore its easy
to mutate state if you're not careful or purposely decide to.

In the sections below, I've purposely followed the same outline as Pete Hunt's original [blog post](https://facebook.github.io/react/docs/thinking-in-react.html).  In my code examples, I've also purposely used the same names for the components, props, and state. Hopefully this should help to
comphrehend the similarities and differences. So make sure you have a good read through and understanding of Pete's post before diving any
further below.

Todo: Keep this in the introduction?
Given a mock from our designer, we immediately begin thinking about how we can
translate the mock into Elm's Model-Update-View pattern.  Moreover, the steps outlined in Pete's blog post are almost the same as in Elm.
We 1) Break the UI into a component heirachy; 2) Build a static version 3) Identify the minimal ( but complete ) representation of UI state;
and finally 4) Figure out the actions necessary to update the state, and notify the affected components whenever the state is changed.

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
type alias Product =
  { category : String
  , price : String
  , stocked : Bool
  , name : String
  }
                 
type alias Products = List Product

newProduct : String -> String -> Bool -> String -> Products
newProduct category price stocked name =
  { category = category
  , price = price
  , stocked = stocked
  , name = name
  }

model : Products
model =
  [ newProduct "Sporting Goods" "$49.99"  True  "Football"
  , newProduct "Sporting Goods" "$9.99"   True  "Baseball"
  , newProduct "Sporting Goods" "$29.99"  False "Basketball"
  , newProduct "Electronics"    "$99.99"  True  "iPod Touch"
  , newProduct "Electronics"    "$399.99" False "iPhone 5"
  , newProduct "Electronics"    "$199.99" True  "Nexus 7"
  ]
```

## Step 1: Break the UI into a component hierachy
If you read 'Thinkin in React' then you'll find the Following the same approach in the original blog post, we break down the
mock into five components

- FilterableProductTable
  - SearchBar
  - ProductTable
    - ProductCategoryRow
    - ProductRow

## Step 2: Build the static version in Elm
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

