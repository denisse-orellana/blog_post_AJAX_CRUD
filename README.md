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

The controller Post is also generated and will be the one where the CRUD is going to take place.

```console
rails g controller Post
```

## 3. Implementing the CRUD

First, the routes are established as:

```ruby
Rails.application.routes.draw do
  resources :posts
  root 'home#index'
end
```

Then, the form is added:

```ruby
# posts/_form.html.erb

<%= form_with(model: @post, remote: true) do |form| %>
    <% if @post.errors.any? %>
        <div id="error_explanation">
            <h2><%= pluralize(@post.errors.count, "error") %> prohibited this post from being saved:</h2> 
            <ul>
                <% @post.errors.full_messages.each do |message| %>
                    <li><%= message %></li>
                <% end %>
            </ul>
        </div>
    <% end %>

    <div class="form-group">
        <%= form.label :title, 'Title' %>
        <%= form.text_field :title, class: "form-control" %>
    </div>

    <div class="form-group">
        <%= form.label :content, 'Content' %>
        <%= form.text_field :content, class: "form-control" %>
    </div>

    <div class="actions">
        <%= form.submit %>
    </div>
<% end %>
```

To call a post with his id with AJAX, the new partial post is created as it follows:

```ruby
# posts/_post.html.erb

<tr id="post-<%= post.id %>">
    <th scope="row">1</th>
    <td><%= post.id %></td>
    <td><%= post.title %></td>
    <td><%= post.content %></td>
    <td><%= link_to 'See', post, remote: true, class: 'btn btn-success' %></td>
    <td><%= link_to 'Edit', edit_post_path(post), remote: true, class: 'btn btn-warning' %></td>
    <td><%= link_to 'Delete', post, method: :delete, remote: true, data: { confirm: "Are you sure to delete: #{post.title}?" }, class: 'btn btn-danger' %></td>
</tr>
```

### 3.1 Index

The Index of Home displays the list of posts. The posts are order from descending order in the controller as:

```ruby
# home_controller.rb

class HomeController < ApplicationController
  def index
    @posts = Post.order(:created_at).reverse_order
    @post = Post.new
  end
end
```

In the HTML the information is seen as:

```html
<!-- home/index.html.erb -->

<div id="form"></div>
<div id="showTweet"></div>

<table class="table">
    <thead class="table-light">
      <tr>
          <th scope="col">Id</th>
          <th scope="col">Title</th>
          <th scope="col">Content</th>
          <th scope="col" colspan="3"></th>
      </tr>
    </thead>
    <tbody id="posts">
        <% @posts.each do |post| %>
            <tr id="post-<%= post.id %>">
                <td><%= post.id %></td>
                <td><%= post.title %></td>
                <td><%= post.content %></td>
                <td><%= link_to 'See', post, remote: true, class: 'btn btn-success' %></td>
                <td><%= link_to 'Edit', edit_post_path(post), remote: true, class: 'btn btn-warning' %></td>
                <td><%= link_to 'Delete', post, method: :delete, remote: true, data: { confirm: "Are you sure to delete: #{post.title}?" }, class: 'btn btn-danger' %></td>
            </tr>
        <% end %>
    </tbody>
</table>

<div id="button">
    <%= link_to 'New post', new_post_path, class: 'btn btn-primary', remote: true %>
</div>
```

### 3.2 Show

From the controller the action show is setted as:

```ruby
# posts_controller.rb

class PostsController < ApplicationController
  before_action :set_post, only: [:show] 

  def show
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :title)
  end
```

A new show.js is created where the id **"showTweet"** will show the post in the Index.

```javascript
// posts/show.js.erb

$('#showTweet').html('<%= escape_javascript render(@post, post: @post) %>');
```

### 3.3 Create

The create method is added as:

```ruby
# posts_controller.rb

class PostsController < ApplicationController
  before_action :set_post, only: [:show] 

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save!
        format.js { render nothing: true, notice: 'Post saved!' }
      end
    end
end
```

The create.js will use the id **"posts"** from the Index to render the post just as:

```javascript
// posts/create.js.erb

$('#posts').prepend('<%= j render(@post, post: @post) %>')
$('#form').empty(500) 
$('#button').show(500)
```

### 3.4 Edit

The edit method is added as:

```ruby
# posts_controller.rb

class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show] 

  def edit
  end
end
```

The edit.js will use the id **"form"** from the Index to render the form as:

```javascript
// posts/edit.js.erb

$('#form').html('<%= escape_javascript render('posts/form') %>')
```

### 3.5 Update 

The update method is added as:

```ruby
# posts_controller.rb

before_action :set_post, only: [:edit, :show, :update] 

def update
    respond_to do |format|
      if @post.update!(post_params)
        format.js { render layout: false, notice: 'Updated post' }
      end
    end
end
```

The update.js will take each post by his id and will save the changes made:

```javascript
// posts/update.js.erb

$('#form').empty(500);
$('#post-<%= @post.id %>').replaceWith('<%= j render(@post, t: @post) %>')
```

### 3.6 Delete

The delete method is added as:

```ruby
# posts_controller.rb

before_action :set_post, only: [:edit, :show, :update, :destroy] 

def destroy
    respond_to do |format|
      if @post.destroy!
        format.js { render layout: false, notice: 'Post deleted!' }
      end
    end
end
```

The destroy.js will delete the indicated post:

```javascript
// posts/destroy.js.erb

$('#post-<%= @post.id %>').empty();
```

## 4. Adding the Search bar

The search bar is added to the beginning of the Index page as:

```ruby
<%= form_with(url: "", method: :get, remote: true, class: "form-inline") do %>
    <%= text_field_tag :q, "", class: "mr-sm-1" %>
    <%= submit_tag("Search", class: "btn btn-outline-success my-1 my-sm-0") %>
<% end %>
```

A new partial for the searched posts is created:

```ruby
# posts/_posts.html.erb

<% @posts.each do |post| %>
    <tr id="post-<%= post.id %>">
        <td><%= post.id %></td>
        <td><%= post.title %></td>
        <td><%= post.content %></td>
        <td><%= link_to 'See', post, remote: true, class: 'btn btn-success' %></td>
        <td><%= link_to 'Edit', edit_post_path(post), remote: true, class: 'btn btn-warning' %></td>
        <td><%= link_to 'Delete', post, method: :delete, remote: true, data: { confirm: "Are you sure to delete: #{post.title}?" }, class: 'btn btn-danger' %></td>
    </tr>
<% end %>
```

Then, in the controller the search is done by the title and content of the posts: 

```ruby
class HomeController < ApplicationController
  def index
    @post = Post.new

    @posts = "COALESCE(title, '') LIKE '%'"
    unless params[:q].nil?
      posts = "COALESCE(title, '') LIKE '%" + params[:q] + "%' OR COALESCE(content, '') LIKE '%" + params[:q] + "%'"
    end
    @posts = Post.where(posts)
  end
end
```

Finally, the id **"posts"** from the Index will render the post searched by the keyword just as:

```javascript
// home/index.js.erb

$('#posts').html('<%= escape_javascript render('posts/posts') %>')
```