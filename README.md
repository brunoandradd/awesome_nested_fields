Awesome Nested Fields
=====================

In Rails, you can create forms that have fields from nested models. For example, if a person has many phone numbers, you can easily create a form that receives data from the person and from a fixed number of phones. However, when you want to allow the person to insert multiple, indefinite phones, you're in trouble: it's [much harder](http://railscasts.com/episodes/196-nested-model-form-part-1) [than it](http://railscasts.com/episodes/197-nested-model-form-part-2) [should be](http://stackoverflow.com/questions/1704142/unobtrusive-dynamic-form-fields-in-rails-with-jquery). Well, not anymore.


Installation
------------

### Rails 3.1

1. Add the gem to your Gemfile and run `bundle install` to make sure the gem gets installed.

        gem 'awesome_nested_fields'

2. Add this line to `app/assets/javascripts/application.js` (or where you prefer) so the javascript dependency is added to the asset pipeline. Be sure to include this line after jQuery and jQuery UJS Adapter.

        //= require jquery.nested-fields

3. Rock with your _awesome_ nested models.


### Rails 3.0

1. Add the gem to your Gemfile and run `bundle install` to make sure the gem gets installed. Be sure to include it after `jquery-rails` so the javascript files are added in the correct order at the templates.

        gem 'awesome_nested_fields'

2. Copy the javascript dependency to `public\javascripts` by using the generator.

        rails generate awesome_nested_fields:install

3. (Optional) The javascript dependency will be added automatically to the defaults javascript files. If you don't use `javascript_include_tag :defaults` in your templates for some reason, require the file manually.

        <script src="/javascripts/jquery.nested-fields.js" type="text/javascript"></script>

4. Now you're ready to rock with your _awesome_ nested models. It will be so fun as in Rails 3.1, I promise.


Basic Usage
-----------

### Model

First, make sure the object that has the `has_many` or `has_and_belongs_to_many` relation accepts nested attributes for the collection you want. For example, if a person _has_many_ phones, we'll have a model like this:

        class Person < ActiveRecord::Base
          has_many :phones
          accepts_nested_attributes_for :phones, allow_destroy: true
        end

The `accepts_nested_attributes_for` is a method from Active Record that allows you to pass attributes of nested models directly to its parent, instead of instantiate each child object separately. In this case, `Person` gains a method called `phones_attributes=`, that accepts data for new and existing phones of a given person. The `allow_destroy` option enables us to also delete child objects. To know more about nested attributes, check out the [ActiveRecord::NestedAttribute](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/nested_attributes.rb#L1) class.

### View

The next step is set up the form view using the `nested_fields` helper method. It receives three parameters: the parent form builder, the association name and an optional hash of options (humm, a pun).
Proceeding with the person/phones example, we can have a form like this:

        <%= form_for(@person) do |f| %>
          <% # person fields... %>

          <h2>Phones</h2>
          <div class="container">
            <%= nested_fields(f, :phones) %>
          </div>
          <a href="#" class="add">add phone</a>

          <% # more person fields... %>
        <% end %>

The `nested_fields` helper lists the phones this person has and also adds an empty template to the page for creating new phones. But where is the phone form? Well, awesome_nested_fields expects a partial with the association name in the singular (after all, the partial represents a single child object). In this case, it looks for the partial `phone` (we can change this name later). So, in the file `_phone.html.erb`, we can have:

        <fieldset class="item">
          <%= f.label :where %>
          <%= f.text_field :where %><br/>
            
          <%= f.label :number %>
          <%= f.text_field :number %>

          <a href="#" class="remove">remove</a>
          
          <%= f.hidden_field :id %>
          <%= f.hidden_field :_destroy %>
        </fieldset>

If you're paying attention, you noticed the key elements are marked with a special class name. We need this for the javascript code, so it knows what to do with each HTML element: the one that have the children must have the class `container`; each child must be marked with the class `item`; inside an item, the link for removal must have the class `remove`; and the link to add new items must have the class `add`. We can change the names later, but these are the default choices. Finally, don't forget to add the `id` field, as it is needed by AR to identify if this is an existing or a new element, and the `_destroy` field  to activate deletion when the user clicks on the remove link.

### Javascript

This is the easiest part: just activate the nested fields actions when the page loads. We can put this in the `application.js` file (or in any other place that gets executed in the page):

        $(document).ready(function(e) {
          $('FORM').nestedFields();
        });

Now enjoy your new nested model form!


Compatibility
-------------

awesome_nested_fields works only with Rails 3.0 and Rails 3.1. Sorry, Rails 2.x users.


TODO
----

* Write tests
* Write awesome demos
* Make sure it can degrade gracefully
* Return and API object on JS to make interaction easier
* Make `nested_fields` call compatible with Rails `fields_for`


Copyleft
--------
Copyleft (c) 2011 Lailson Bandeira (http://lailsonbandeira.com/). See LICENSE for details.