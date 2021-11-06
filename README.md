# Blog Post: AJAX CRUD

This project presents a simple blog post developing the CRUD (Create, Read, Update and Delete) from zero with AJAX (Asynchronous JavaScript and XML) without the use of scaffold.

## 1. Adding Bootstrap

First, the next gems are integrated and bundled:

```ruby
# gemfile.rb

gem "bootstrap", "~> 5.1"
gem "jquery-rails", "~> 4.4"
```

Then, in the javascript manifest the Bootstrap is require as:

```javascript
// application.js

//= require jquery
//= require popper
//= require bootstrap
```

And finally, Bootstrap is called from the SCSS file in the main view:

```css
/* home.scss */

@import 'bootstrap';
```

## 2. Defining the model

<p align="center"><img width="30%" src="app/assets/images/post_model.png"></p>

## 3. Implementing the CRUD

### 3.1 Index
### 3.2 Show
### 3.3 Create
### 3.4 Update 
### 3.5 Delete

## 4. Adding the Search bar