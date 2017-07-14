# Pokedex: Part 1 - Jbuilder, React, Redux

In this project, we'll write an React/Redux/Rails app to manage `Pokemon` and their `Items`!
Check out the live demo [here](http://aa-pokedex.herokuapp.com/)!

Note: The singular and plural forms of the word "pokemon" do not
differ.

## Phase 0: Rails API Setup
We've already set up a Rails backend with migrations and models in the
[skeleton][skeleton-zip].

* Download the [skeleton][skeleton-zip].
* Run `bundle install`.
* Make sure Postgres is running, then run `rake db:setup` (short for `rake db:create db:schema:load db:seed`).

Get yourself oriented.

* Take a look at the `schema`, `routes`, and `StaticPagesController`.
* Also look at the `Pokemon` and `Item` models.
* Open up the rails console (`rails c`) to see what's in the database.
* Start up the rails server (`rails s`) and visit the root url.

[skeleton-zip]: ./skeleton.zip?raw=true

### API Namespace

Let's build routes for our pokemon! We want these routes to be nested under an api namespace.
Like so:

```ruby
namespace :api, defaults: {format: :json} do
  resources :pokemon
end
```

The `defaults: {format: :json}` option tells the controller to first look for a `.json.jbuilder` view rather than an `html.erb` view.

Edit your `routes.rb`. Your routes table should look like the following:

```
           Prefix Verb   URI Pattern                Controller#Action
             root GET    /                          static_pages#root
api_pokemon_index GET    /api/pokemon(.:format)     api/pokemon#index {:format=>:json}
                  POST   /api/pokemon(.:format)     api/pokemon#create {:format=>:json}
      api_pokemon GET    /api/pokemon/:id(.:format) api/pokemon#show {:format=>:json}
                  PATCH  /api/pokemon/:id(.:format) api/pokemon#update {:format=>:json}
                  PUT    /api/pokemon/:id(.:format) api/pokemon#update {:format=>:json}
                  DELETE /api/pokemon/:id(.:format) api/pokemon#destroy {:format=>:json}
```

### Pokemon Controller

Build a controller to handle our pokemon `resources`.

* Generate an `Api::PokemonController`.
* Define `#index` and `#show` actions.

Remember, we want these actions to **render json responses**.
To make the job easier for our frontend, you should format your index action to serve up json responses that look something like this:

```js
{
  1: {
    id: 1,
    name: /*...*/,
    image_url: /*...*/
  },
  2: {
    id: 2,
    name: /*...*/,
    image_url: /*...*/
  },
  //..
}
```

Here, the keys in your json response are the primary keys of the pokemon.
The values are the pokemon objects themselves.
Let's use Jbuilder here!

* Create a `views/api/pokemon/index.json.jbuilder` file.
* Iterate over each pokemon.
* Use `json.set!` to explicitly set the key to the pokemon's id.
* Use `json.extract!` to grab the pokemon's `id`, `name`, and
`image_url`.

Like so:

```ruby
@pokemon.each do |poke|
  json.set! poke.id do
    json.extract! poke, :id, :name
    json.image_url asset_path(poke.image_url)
  end
end
```

**NB** Notice that we use the `asset_path` helper to find the correct
path to the image.
Asset locations can be different in production so you should always use `asset_path` rather than a literal path.
For more detail [check out the guides](http://guides.rubyonrails.org/asset_pipeline.html).

We don't need to return any more information than this for our index route!
Remember, Jbuilder allows us to *curate* our data, retrieving only the attributes we are interested in.

* Next create a Jbuilder view for `PokemonController#show`.
We want the action to render all the information about a single pokemon, including its items.
In this case, we are listing the poke and items separately, since they represent separate resources.
The reasoning behind this will become more clear, when we normalize our state on Day 2.

A GET request to `localhost:3000/api/pokemon/5` should render this:

```js
{
  poke: {
    id: 5,
    name: "Rhydon",
    attack: 130,
    defense: 120,
    image_url: "/assets/pokemon_snaps/112.png",
    moves: [
      "horn attack",
      //...
    ],
    poke_type: "ground",
  }
  items: [
    {
      id: 15,
      name: "Dark Vulcan",
      pokemon_id: 5,
      price: 12,
      happiness: 58,
      image_url: "/assets/pokeball.png"
    },
    //...
  ]
}
```

**Test your routes, controller actions and Jbuilder view**: Make GET requests to (i.e. visit) `localhost:3000/api/pokemon` and `localhost:3000/api/pokemon/:id`.
Show a TA before moving on.


## Phase 1: Frontend Setup

### Node Package Manager

As with previous projects, you will need to set up a `package.json` and a `webpack.config.js` file to configure your application to use NPM and Webpack.

* Run `npm init -y` to initialize your app's `package.json` with the default boilerplate settings.
* `npm install --save` the following packages:
  * webpack
  * react
  * react-dom
  * react-router-dom
  * redux
  * react-redux
  * redux-logger
  * babel-loader
  * babel-core
  * babel-preset-es2015
  * babel-preset-react
  * lodash

### Webpack

Next we need to configure Webpack to compile our `bundle.js` file.

* Create a new file called `webpack.config.js` in the root of your project.
* Copy and paste the following configuration:

  ```js
  const path = require('path');

  module.exports = {
    context: __dirname,
    entry: './frontend/pokedex.jsx',
    output: {
      path: path.resolve(__dirname, 'app', 'assets', 'javascripts'),
      filename: 'bundle.js'
    },
    resolve: {
      extensions: ['.js', '.jsx', '*']
    },
    module: {
      loaders: [
        {
          test: /\.jsx?$/,
          exclude: /(node_modules)/,
          loader: 'babel-loader',
          query: {
            presets: ['react', 'es2015']
          }
        }
      ]
    },
    devtool: 'source-maps'
  };
  ```


> #### :bulb: Aside: How does Rails get `bundle.js`?
>
> Take a look in `app/assets/application.js`.
> You should see a few `require` statements.
>
```js
//= require jquery
//= require jquery_ujs
//= require_tree .
```
>
> Though these lines appear to be commented out, they are actually embedding the content of these files/libraries into our `application.js` file.
> They are embedded in the order in which they appear.
> In this case we are requiring `jquery`, then `jquery_ujs` (adds our CSRF token to each `$.ajax` call; has `jquery` as a dependency) libraries before including our own local files.
> `require_tree .` includes all the files in the same directory (hence the `.` of relativity), which will include our `bundle.js` file once it has been webpacked.
> If including local files is a certain order is required for your app, you will need to `require` them individually as `require_tree` does not guarantee ordering.

Notice that the `entry` key in `webpack.config.js` expects a file called `./frontend/pokedex.jsx` to exist.

* Create a `frontend` folder in the root directory of your project.
* Add an entry file called `pokedex.jsx`.
* `import` both the `react` and `react-dom` packages.
* Add an event listener for `DOMContentLoaded`.
* In the callback to this listener, try rendering a simple stateless React component to test everything we've written so far.
* Don't forget to run `webpack --watch` to generate your `bundle.js`.

Your entry file might look like the following:

```js
// frontend/pokedex.jsx

import React from 'react';
import ReactDOM from 'react-dom';

document.addEventListener('DOMContentLoaded', () => {
  const rootEl = document.getElementById('root');
  ReactDOM.render(<h1>Pokedex</h1>, rootEl);
});
```

**Test your frontend setup**: Make sure that your test component renders
at the root.

### Frontend Structure
Finish your frontend setup by defining the structure of your `frontend` folder.
Nest folders called `actions`, `components`, `reducers`, `store`, `middleware` and `util` within `frontend`.

## Phase 2: `Pokemon` Redux Cycle

### Designing the State Shape

Before we actually build anything, we need to talk about the shape of
our application state. **This is an important first step!** Don't ever
skip it. For now, we just want to be able to render all of our pokemon.
This means we'll probably want a `pokemon` slice of state that returns a
collection of pokemon objects.

Sample state shape:

```js
{
  pokemon: {
    1: {
      id: 1,
      name: /*...*/,
      image_url: /*...*/
    },
    2: {
      id: 2,
      name: /*...*/,
      image_url: /*...*/
    },
    //...
  }
}
```

We recommend using an object to store collections of objects in an app's state.
While this may impose a few more obstacles for iterating over the collection to render, an object will prove far superior for updating or deleting individual pokemon in our collection (re: time complexity of objects vs array methods). Note the current sample state looks a lot like the json response returned by the `PokemonController#index` action.

### API Util and Action Creators

We'd like to render all of our pokemon. Let's start by setting up a way to fetch them from the back end.

* Create an `api_util.js` file inside your `frontend/util` folder.
  * Inside this file, we'll define functions that make ajax requests
fetching information from our rails api.
* Export a function called `fetchAllPokemon` that returns a promise.
  * The function should make an AJAX request that will make a http request to our `PokemonController#index` endpoint.
  * Run `rake routes` to determine the appropriate url for this request.

Next, define an action creator to be called on success of
`APIUtil#fetchAllPokemon`.

* Create a `pokemon_actions.js` file within your `frontend/actions`
folder.
* Export a constant called `RECEIVE_ALL_POKEMON` with the value
`"RECEIVE_ALL_POKEMON"`
* Export a function called `receiveAllPokemon(pokemon)` that returns an
action object.
  * This action object should have two keys: `type` of
`RECEIVE_ALL_POKEMON` and another for the received `pokemon` data.

Your code should look like the following:

```js
// frontend/actions/pokemon_actions.js

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
})
```

**Test that your pokemon action creator and api util work in the browser
before moving on!**
* Import the action and api_util functions into your entry file.
* Assign them to the `window` to test that in the browser's console.
* You should be able to run:

  ```js
  const getSuccess = pokemon => console.log(receiveAllPokemon(pokemon));
  fetchAllPokemon().then(getSuccess);
  ```

### `pokemonReducer`

Let's define our `pokemonReducer`.
Remember that the reducer is only concerned with describing how the state changes as a result of a dispatched action. It takes two parameters: the previous `state` and the `action` dispatched.
It should return the new state, without mutating the previous `state`.
If the reducer doesn't care about the action being dispatched, it should return `state`.

* Create a `frontend/reducers/pokemon_reducer.js` file.
* Import our `RECEIVE_ALL_POKEMON` constant.

  ```js
  import { RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';
  ```

* Define and `export default` a `pokemonReducer(state = {}, action)`.
* Add a `switch(action.type)` statement.
* Create `RECEIVE_ALL_POKEMON` and default cases.
Remember not to mutate `state`!

### The `rootReducer`

Before we can use our `pokemonReducer`, let's create a `rootReducer` using Redux's `combineReducers` function.
We'll use `combineReducers` to generate our application state and assign each slice of the state to a different reducer. This will make it easier to grow our application state.

* Create a new file: `/frontend/reducers/root_reducer.js`
* Import `combineReducers` from `redux` and our `pokemonReducer`:
* Call `combineReducers` so that our `pokemonReducer` is responsible for
the `pokemon` slice of the app state. Like so:

```js
const rootReducer = combineReducers({
  pokemon: pokemonReducer
});
export default rootReducer
```

### Store

Before we can test our app's reducer we need a Redux store to dispatch
from. Let's create our app's store.

* Create a `store.js` file within the `frontend/store` folder.
* Import `createStore` and `applyMiddleware` from the `redux` package.
* Import our `rootReducer`
* Import `logger` the default export of `redux-logger` middleware

Redux's `createStore` function accepts the following parameters: the
reducer, an optional `preloadedState`, and any enhancers like as
middleware.

* For now, call `createStore` and pass it our imported `rootReducer` and `logger` as our only middleware.
Remember, middlewares need to be wrapped in a call to `applyMiddleware` when passed to `createStore`.
We will come back to the other arguments later.
* Wrap the creation of the store in a `configureStore` function. Like
so:

  ```js
  // frontend/store/store.js

  const configureStore = () => createStore(rootReducer, applyMiddleware(logger));
  ```

  > #### :bulb: Aside: `configureStore` Pattern
  > This is a great pattern to continue using - instead of just exporting the store, we are exporting a function that creates and returns a `store`.
  > This can be used in the future to swap out reducers, `preloadedState`, or enhancers depending on different conditions (e.g. development vs production environments).

* In your `pokedex.jsx` entry file, import your `configureStore`
function.
* Inside the `DOMContentLoaded` callback, declare a `store`.
* Call `configureStore` and assign its return value to `store`.
* For **testing purposes only**, make `getState` and `dispatch` available on the `window` (i.e. `window.getState = store.getState; window.dispatch = store.dispatch`).
  * We want to avoid placing our entire `store` on the window as it can create scoping issues and create some nasty bugs

**Test your store and reducer.** You should be able to run the following
code snippet in the browser's console:

```js
getState(); // should return initial app state

const getSuccess = pokemon => dispatch(receiveAllPokemon(pokemon));
fetchAllPokemon().then(getSuccess);

getState(); // should return the app state populated with pokemon
```

### Thunk Middleware

Create a new file `frontend/middleware/thunk.js` and export your thunk
middleware. It should check the typeof incoming actions and either
return `action(dispatch)` if they are functions, or `next(action)` if
they are not. Reference yesterdays solutions if you need more guidance.

* Refactor your `configureStore` function to incorporate your `thunk
middleware`.

  ```js
  // frontend/store/store.js
  import thunk from '../middleware/thunk';

  const configureStore = () => (
    createStore(
      rootReducer,
      applyMiddleware(thunk, logger)
    )
  );
  ```

#### Connecting the Dots

Let's add a new thunk action creator `requestAllPokemon`, dispatching a `RECEIVE_ALL_POKEMON` action if successful.
It should not receive any arguments and should call the `APIUtil`, and then on resolution of the promise, dispatch `receiveAllPokemon`.

This one's free!

```js
export const requestAllPokemon = () => (dispatch) => {
  return APIUtil.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
}
```

**Test your redux cycle**. In the browser console try:

```js
getState(); // should return initial app state
dispatch(requestAllPokemon());
getState(); // should return the app state populated with pokemon
```

You've done it! You have successfully built out an api endpoint, and setup a Redux cycle for your pokemon! :tada:

### Selectors

We're going to add one final piece to our redux structure: selectors.
Selectors are functions that are used to "select" complex pieces of the state.
Define them in a `selectors.js` file in your app's `frontend/reducers` folder.

* Create a `frontend/reducers/selectors.js` file.
* Define and export a function, `selectAllPokemon(state)`, which accepts the application state as an argument and exports an array of all the pokemon objects.
You can use [lodash's values][lodash-values] method.

**Test your selector in the browser**. You should should be able to do
the following:

```js
const initialState = getState();
selectAllPokemon(initialState); //=> []

dispatch(requestAllPokemon());

const populatedState = getState();
selectAllPokemon(populatedState); //=> array of pokemon objects!
```

We'll use this selector later in our pokemon components.
**Show a TA your bug-free pokemon redux cycle before moving on!**
Make sure you can explain how the different pieces of Redux fit together (i.e. state shape, actions, reducer, store, middleware and selector).

[lodash-values]: https://lodash.com/docs/4.16.4#values

## Phase 3: `Pokemon` React Components

### The `Root` Component

* Create a `Root` component that will be responsible for rendering all of the app's React components.
    * `Root` should be a *stateless* component (i.e. a *functional
component*).
    * It will be passed the app's  Redux`store` as a prop.
    * It should wrap our all of our app's components with the `Provider` from `react-redux`.

Your `Root` component should look like this:

```js
import React from 'react';
import { Provider } from 'react-redux';

const Root = ({ store }) => (
  <Provider store={store}>
    <div>Hello, world!</div>
  </Provider>
);

export default Root;
```

**NB**: Remember that anywhere we use JSX, we *must* import React.

* Update your doc-ready callback in the entry file `pokedex.jsx` to:
  * Import your newly defined `Root` component;
  * and render it, passing is the `store` as a prop.

Like so:

```js
document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root);
});
```

**Test that your `Root` component is properly rendered before moving on.**

### `PokemonIndex`

Remember that there are two types of React components: presentational components and container components.
**Container components** (i.e. containers) are concerned with subscribing to the store, reading from state, and passing down necessary props to presentational components.
Our **presentational components** are concerned with rendering JSX and defining the user interface.

#### `PokemonIndexContainer`

* Create a `frontend/components/pokemon` folder.
This will house all of the React components concerning the `pokemon` slice of state.
* With this folder, create a `pokemon_index_container.js` file.
* As with all container components, import the `connect` function from the `react-redux` package.

The `connect` function accepts two functions as arguments: `mapStateToProps` and `mapDispatchToProps`.
Both functions are invoked when our redux store updates.
They are responsible for determining and constructing the props that are passed to presentational component.

* Define `mapStateToProps`.

  ```js
  const mapStateToProps = state => ({
    // piece of state that container subscribes to
  });
  ```

* Define `mapDispatchToProps`.

  ```js
  const mapDispatchToProps = dispatch => ({
    requestAllPokemon: // dispatch requestAllPokemon action.
  });
  ```

* Import your `selectAllPokemon` selector.
* Use it to pass a `pokemon` prop to the connected presentational component `PokemonIndex`. `this.props.pokemon` in `PokemonIndex` will return an array of all the pokemon objects in the app state.
* In the next phase we'll actually define our `PokemonIndex` component in `frontend/components/pokemon/pokemon_index.jsx`. Assume it already exists, and import it.
* `connect` `PokemonIndex` and export the returned component. Like so:

  ```js
  export default connect(
    mapStateToProps,
    mapDispatchToProps
  )(PokemonIndex);
  ```

#### `PokemonIndex`

Now let's write the `PokemonIndex` presentational component, which should render an unordered list of pokemon names next to corresponding images.

* Create a `frontend/components/pokemon/pokemon_index.jsx` file.
* Define and export a *class*, component that renders a `<li>` for each pokemon object in the `this.props.pokemon` array.
  * Display the pokemon's name and a *small* image.
* Inside of `componentDidMount`, call `this.props.requestAllPokemon`
* Import the container component to `root.jsx`.
* Nest and render a `<PokemonIndexContainer />` within your `<Root />` component.

**Test your `PokemonIndex` components**: To start, your app should render an empty `ul` reflecting your app's initial state, after the request to `requestAllPokemon` succeeds the ul should be populated with pokemon.
Look for webpack and console errors when debugging.

Now you should see your list of pokemon whenever you refresh the page.
Go ahead and remove all other extraneous action creators, constants, and code snippets used for testing from our entry point if you haven't already.
**Show a TA that your pokemon React components render before moving on!**

### Continuing to [Part 2](./pokedex_ii.md)
Before continuing with second part of Pokedex, complete the steps:
* Return to and complete the [Jbuilder Bonus](../jbuilder/README.md#bonus)
* Read tonight's material on [React Router](../../README.md#w7d4)

Now, proceed to [Part 2](./pokedex_ii.md).

# Pokedex: Part 2 - An Introduction to React Router

Check out the live demo [here][live-demo]!

[live-demo]: http://aa-pokedex.herokuapp.com/

## Phase 4: React Router

Now let's say we want the ability to click on any of the listed pokemon and see more details about them.
In order to maintain a common user interface used around the web, we will have the URL define what components the user sees.
This is exactly what the powerful `react-router-dom` package is for.
To use it, navigate to your `pokedex.jsx` file and import the following:

```js
import { HashRouter, Route } from 'react-router-dom';
```
Refer to the [react-router-dom documentation][routes-docs] as a reference.

[routes-docs]: https://reacttraining.com/react-router/web/guides/quick-start

### Adding the `Router`

The React-Router `<HashRouter />` component is the primary component which wraps our route hierarchy.
It is responsible for listening for changes to our browser's url.
When the url changes, the `HashRouter` determines which component to render based on which `Route`'s `path` matches the url.

* Wrap the `HashRouter` in your app's `Root` and `Provider`.
Define your `Root` after you've defined `store` (within your `addEventListener` callback).

Your `Root` should now look like this:

```js
import { HashRouter, Route } from 'react-router-dom';

const Root = () => (
  <Provider store={store}>
    <HashRouter>
      // primary route will go here
    </HashRouter>
  </Provider>
);
```

### Adding a `Route`

Instead of rendering the `PokemonIndexContainer` directly, setup a root
`Route` that will render the component when `path="/"`. Like so:

```js
<Provider store={ store }>
  <HashRouter>
    <Route path="/" component={ PokemonIndexContainer } />
  </HashRouter>
</Provider>
```

**Test that your `PokemonIndex` component still renders at your app's
root url**

### `PokemonIndexItem`

Let's refactor your presentational component so that each pokemon object is rendered in a `PokemonIndexItem` component.
As your app grows, refactor components to keep them minimal and modular.

Create a `frontend/components/pokemon/pokemon_index_item.jsx` file and export a functional `PokemonIndexItem` component.
Your `PokemonIndexItem` should return a `li` containing information on a pokemon's `name` and `image_url`.
This information should be served as props. Refactor `PokemonIndex` to utilize this new component.
Your `PokemonIndex` should map each pokemon objects in `this.props.pokemon` to a `PokemonIndexItem`.
It should look something like this:

```js
const pokemonItems = pokemon.map(poke => <PokemonIndexItem key={poke.id} pokemon={poke} />);

// And inside the render:
<section className="pokedex">
  <ul>
    {pokemonItems}
  </ul>
</section>
```

**Test your code** to ensure everything still renders as it did before.

Let's add functionality to our app.
Every time a user clicks on a `PokemonIndexItem` we wanted to route them to a `/pokemon/:id` path and render a `PokemonDetail` component.
To see this in action check out the [live demo][live-demo].

* Import `Link` to your `PokemonIndexItem` like so:

  ```js
  import { Link } from 'react-router-dom';
  ```

Inside each li, wrap the pokemon information in a `Link` tag.
Give it a `to` prop with the path for the frontend pokemon show page (`/pokemon/:pokemonId`).

The `Link` tag will generate an appropriate link to this path.
While it would be possible to accomplish the same thing with an `a` tag and an `href` property, using React Router's own `Link` tag is less brittle and will do the right thing, even if we use `BrowserRouter` rather than `HashRouter` for example.

While clicking on a `PokemonIndexItem` will change the browser's url, you may have noticed that nothing is happening. We need a `Route` to render when we visit `/pokemon/:pokemonId`. Let's make one.

## Phase 5: `PokemonDetail`

Start by defining that component the `Route` will render: `PokemonDetail`.

Before defining a new component and adding it to your app, you should always plan out where and how it will get its information.
We want the `PokemonDetail` to display a Pokemon's information as well as its `Items`.
Talk over the following questions with your partner:

* Where will the `PokemonDetail` get its information from?
* How will we pass this information to `PokemonDetail`?

Hint: Your state shape will look something like this:
```js
// Sample State Shape
{
  pokemon: {
    entities: {
      1: {
        id: 1,
        name: "Pikachu",
      },
      2: {
        id: 2,
        name: "Rhydon",
        attack: 130,
        defense: 120,
        image_url: "/assets/pokemon_snaps/112.svg",
        moves: [
          "horn attack",
          //...
        ],
        poke_type: "ground",
      }
    },
    // Rhydon is the pokemon we want to show in PokemonDetail component
    // so we keep it's id here to signify that is has been fetched and fully
    // loaded into entities
    currentPoke: 2,
  }
  // this slice will contain an array of the items of the currentPoke
  items: [
    {
      id: 15,
      name: "Dark Vulcan",
      pokemon_id: 2,
      price: 12,
      happiness: 58,
      image_url: "/assets/pokeball.png"
    },
    //...
  ]
}
```

Implement the `PokemonDetail` component just like we did the `PokemonIndex`. Make sure to **test at each step!**

* Create an API utility function that fetches a single pokemon.
* Create actions for receiving a single Pokemon.
This requires defining a new constant and action creator.
* Update `PokemonReducer` shape to contain `entities` and a `currentPoke`.
  * Don't forget to update the `Switch` also!
* Create an `ItemsReducer` to contain the `currentPoke`'s items.
* Create a `requestSinglePokemon` thunk action creator.
* Create a `PokemonDetailContainer` that maps props to `PokemonDetail`.
* Create a class `PokemonDetail` component that returns information of the pokemon.
* Add a `Route` that renders the `PokemonDetailContainer` component when the url matches the path `"/pokemon/:pokemonId`".
  * We'll add the `Route` to the end of our `PokemonIndex` render function.
  * Inside of `PokemonDetail` on `componentDidMount`, call `this.props.requestSinglePokemon`.
  Pass it the pokemon's id from the `this.props.match.params.pokemonId`.

Once it works, try navigating to the route of a different pokemon.
Your detail view won't update.
This is because although the props (`this.props.match.params.pokemonId`) have changed, the component didn't remount.
So we never requested the new pokemon.
We need to trigger a request on the props changing.
There is a lifecycle method we can tap into to accomplish this: `componentWillReceiveProps(newProps)`.

* In your `PokemonDetail` component, on `componentWillReceiveProps(newProps)`, call `this.props.requestSinglePokemon(newProps.match.params.pokemonId)`, but only if  the `pokemonId` has changed.
You can check your current props to find out the previous value.

**Test your `PokemonDetail` redux cycle and route!** Does it behave like
the [live demo][live-demo]? Show a TA before moving on.

## Phase 6: `ItemDetail`

Let's add more functionality and another Route.
When a user clicks on an item from a pokemon's `PokemonDetail`, the router should redirect to a path `/pokemon/:pokemonId/items/:itemId` where an `ItemDetail` component displays information about an `Item` within the `PokemonDetail` component.
This should be implemented without any changes to the application state because items are loaded into the `pokemonDetail` slice of state when a single pokemon is selected.
* Create an `ItemDetailContainer` that receives an item's information as
`props`.
  * When providing the item to the `ItemDetail` component from the `ItemDetailContainer`, remember that `mapStateToProps` accepts a
second parameter `ownProps`.
`ownProps.match.params` returns the params object.
  * Use `ownProps.match.params.itemId` to select the correct item from the `state`.
  * Define a new `selectPokemonItem(state, itemId)` selector and call it in `mapStateToProps`.
* Create a functional `ItemDetail` component that displays its `item` prop.
  * `ItemDetailContainer` connects it to the store.
* Create a new route that renders the `PokemonIndexContainer`, `PokemonDetailContainer` and `ItemDetailContainer` when the path matches `/pokemon/:pokemonId/items/:itemId`.

Hint: nest your new `Route` under the render function of `PokemonDetail`.

Your app's `HashRouter` should contain the following routes:

```jsx
// pokedex.jsx
<HashRouter>
  <Route path="/" component={PokemonIndexContainer} />
</HashRouter>

// pokemon_index.jsx
<Route path="/pokemon/:pokemonId" component={PokemonDetailContainer} />

// pokemon_detail.jsx
<Route path="/pokemon/:pokemonId/item/:itemId" component={ItemDetailContainer} />
```

**Test your `ItemDetail` components and route!** Does it behave like the
[live demo][live-demo]? Show a TA before moving on.

## Phase 7: Creating Pokemon

Our next feature will be to allow the creation of new Pokemon. To allow users to create Pokemon, you will need to:

* Define a `#create` controller action for the `PokemonController`.
* Create an API function that sends a single Pokemon's information as part of a `POST` request to the backend.
* Create actions for both creating and receiving a new Pokemon (creation should be a thunk, receiving is a regular action).
* Update the reducer to respond to receiving a new Pokemon.
* Create a `PokemonFormContainer` that only connects `mapDispatchToProps`.
  * Pass a function prop called `createPokemon` that dispatches your `CREATE_POKEMON` action.

**Test at each step!**

### `PokemonForm`

Create a controlled `PokemonForm` component.

Remember, a **controlled component** is one which overrides the default functionality of the browser, allowing your code to entirely control your application.
This is most commonly used in forms to ensure that input field values are being tracked in internal state and that submit buttons perform actions as described by the application.

Use the `constructor()` method to provide a default internal state to your form.
Even though Javascript convention is to use camelCase, it is often easiest to define data in the format our server expects when making a "POST" request.  
In Ruby, this means snake_case.

Normally these constructor functions are taken care of by React.
In this case, we are overriding the constructor function to have a default internal state, so it is our responsibility to make sure all functions are properly bound. Like so:

```javascript
class ControlledComponent extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      //...
    };

    this.exampleMethod = this.exampleMethod.bind(this);
  }
  //...
}
```

For the input elements, use an `onChange` listener and write a single `update` function to call the `setState` method.

An basic example of an `update` method is below:
```js
class ControlledComponent extends React.Component {
  //...

  update(property) {
    return e => this.setState({[property]: e.target.value});
  }

  //...
}
```

The best html element for the Pokemon type is a `<select>` element, which appears to the user as a dropdown.
Copy / paste the array of pokémon types from the model and use it in your `PokemonForm`.

Write a `handleSubmit` method as well that prevents the default event action and instead calls the `createPokemon` function from props.
Make sure to pass this function to the `onSubmit` listener of the form.

We want this form to appear when at the same root path as the `PokemonIndex`, but not at any further nested routes like the `PokemonDetail`.
To do so, we'll add a new `Route` to our `PokemonIndex` and use `exact` prop to only render `PokemonFormContainer`  when the path exactly matches the root path.

**NB**: There are a couple of tricky aspects to getting the form to work properly which will be great debugging practice.
Use a `debugger` in your `postPokemon` function to ensure that you are always passing the correct parameters to your API.

The final parts of the `PokemonForm` are redirecting callback and error handling.

### Redirecting

Once the posting is complete we want the application to redirect to the newly created Pokemon.
We need to wait, however, because we need this Pokemon's ID in order to push to that URL.
We will only have this id after the response has come back from the server, so we can tack on another `.then` after our promise resolves and redirect from there.

Make sure that your `createPokemon` action creator returns the promise and that any `.then` calls you tack onto the end return the pokemon.
The reason for this is that when chaining calls to `then` the return value of the previous is passed as the input to the next.
This can be handy for gradually building up a value, in our case we want to do two things with the same input, so we must pass it through.

Your `createPokemon` should look like this:

```js
export const createPokemon = pokemon => dispatch => (
	APIUtil.postPokemon(pokemon).then(pokemon => {
		dispatch(receiveNewPokemon(pokemon));
		return pokemon;
	});
);
```

In order to get the router to send us to a new location from within the component, we can use `react-router-dom`'s `withRouter` function.
`withRouter` is referred to as a **Higher Order Component** (HOC).
Much like our container components, it serves to pass down information (namely the `history`) through props.

* Import `withRouter` to your `PokemonForm` like so:

  ```js
  import { withRouter } from 'react-router-dom';
  ```

* Call this function on `PokemonForm` before exporting it like so:

  ```js
  export default withRouter(PokemonForm);
  ```

Your `PokemonForm` will now have access to your app's router via `props.history`! We can now use `history.push(path)` to redirect our user to different routes!

On successful submission of your form, redirect the user to the pokemon show page.

```js

class PokemonForm extends Component {
  handleSubmit(e) {
    e.preventDefault();
    this.props.createPokemon(this.state).then((newPokemon) => {
      this.props.history.push(`pokemon/${newPokemon.id}`);
    });
  };
}
```

### Error Handling

The server will tell us whether or not our new Pokemon was created successfully.
But so far, we have no way of letting our users know what happened. We need a way of displaying errors on the front-end after an unsuccessful POST request by adding an `errors` slice to our state.

```js
// Sample State Shape
{
  pokemon: {
    //...
  },
  pokemonDetail: {
    //...
  },

  errors: [ "message 1", "message 2" ]
}
```

* Add a `receivePokemonErrors` action and corresponding constant.
* Add a second argument to the `then` method in your `createPokemon` thunk that dispatches `receivePokemonErrors` passing in `errors.responseJSON`.
* Add a new reducer, `ErrorsReducer`, to handle the `errors` slice to your app state.
* Update the `createPokemon` thunk action creator to use this new action on failure
* Add a `mapStateToProps` function that connects to the `PokemonFormContainer`
* Add an errors function to the `pokemonForm` that returns an unordered list of error messages.
* Add a `mapStateToProps` function in the `PokemonFormContainer` to provide the `PokemonForm` with a list of errors

To test that the errors properly show up, try adding a pokemon with the same name as a pokemon that currently exists in the database.
Pokemon names have a `uniqueness: true` constraint, so it should display an error like "Name is already taken".

## Phase 8: Style

A significant portion of the time you spend working on your full-stack project will involve styling.
You'll need to use HTML and CSS to style your project to look good and like the site you're cloning.
Let's practice that now!

Style your app to look like the [live demo][live-demo]. Our HTML/CSS [curriculum][html-css-curriculum], the [Complete Guide to Flexbox][flexbox-guide], and the internet are good resources if you get stuck! :art:


[html-css-curriculum]: ../../../html-css#htmlcss-curriculum
[flexbox-guide]: https://css-tricks.com/snippets/css/a-guide-to-flexbox/

## Phase 9: Loading Spinner

In this phase we'll create a 'loading' spinner that displays while we're fetching information from the backend.

We've supplied the [CSS][pokeball-css] for a pokeball spinner that you can use.
The css animation requires the following html to function:

```html
<div id="loading-pokeball-container">
  <div id="loading-pokeball"></div>
</div>
```

* Feel free to use the pokeball spinner we've provided.
However, you can also Google "css spinner" to find another spinner to implement!
* Before calling the `APIUtil`, have your async actions also dispatch an action with `type: START_LOADING_ALL_POKEMON` for `requestAllPokemon` and an action with `type: START_LOADING_SINGLE_POKEMON` for `requestSinglePokemon`.
* Create a new reducer, the `LoadingReducer`
  * Your `LoadingReducer` should care about all `START_LOADING_` and `RECEIVE_` action types
  * When a request is made, change the loading state to `true`, when the data is received, change the state to `false`
* Change your `PokemonIndex` and `PokemonDetail` components to render the spinner if the loading state is `true`

[pokeball-css]: ./skeleton/app/assets/stylesheets/loading-pokeball.scss

## Phase 10: Bootstrap Poketypes

We have a list of pokétypes in two places: our `Pokemon` model and our `PokemonForm` React component.
This is not very dry. Let's employ a tactic called "bootstrapping" to tell our form all the pokémon types.

* Delete the `POKEMON_TYPES` constant from your `PokemonForm` component
* Open `application.html.erb`
  * Add a `<script>` tag; inside, set the value of `window.POKEMON_TYPES` to the `POKEMON_TYPES` constant used in the `PokemonModel`
  * Use the `#raw` method to tell Rails not to escape the symbols in our array
* Update you `PokemonForm` to use `window.POKEMON_TYPES` instead

```js
window.POKEMON_TYPES = <%=raw Pokemon::TYPES %>
```

## Bonus: Update Pokemon

Create a new front-end route:

```
/pokemon/:id/edit
```

This route should render an edit page where you can update the properties of your Pokemon!
Refactor your `PokemonForm` component so that it can be used to both create and update Pokemon.
You should only have to make one new action and one new api util function:

* `requestUpdatePokemon` action creator
* `updatePokemon` api util function

But you should have to refactor the following pieces:

* `PokemonFormContainer`
* `PokemonForm`

## Bonus: Update Items

Add the ability to reassign items to different Pokemon. This time, design is up to you!
