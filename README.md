# Blog Post: AJAX CRUD

This project presents a simple blog post developing the CRUD (Create, Read, Update and Delete) from zero with AJAX (Asynchronous JavaScript and XML) without the use of scaffold.

## 1. Adding Bootstrap

First, the next gems are integrated and bundled:

```ruby
# gemfile.rb

gem "bootstrap", "~> 5.1"
gem "jquery-rails", "~> 4.4"
```

Then, in the javascript manifest Bootstrap is require as:

```javascript
// application.js

//= require jquery
//= require popper
//= require bootstrap
```

And finally, it is called from the SCSS file in the main view:

```css
/* home.scss */

@import 'bootstrap';
```

## 2. Defining the model

<p align="center"><img width="30%" src="app/assets/images/post_model.png"></p>

The previews image summarize the model and it is generated as it follows from the console:

```console
rails g model Post title content:text
```

Home will be the controller that will display the index and it's generated as:

```console
rails g controller Home index
```

The controller Post is also generated and will be the one where the CRUD is going to take form.

```console
rails g controller Post
```

## 3. Implementing the CRUD

### 3.1 Index
### 3.2 Show
### 3.3 Create
### 3.4 Update 
### 3.5 Delete

## 4. Adding the Search bar