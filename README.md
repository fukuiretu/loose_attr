LooseAttr
===============

![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)
[![Circle CI](https://circleci.com/gh/fukuiretu/loose_attr.svg?style=svg)](https://circleci.com/gh/fukuiretu/loose_attr)
[![Code Climate](https://codeclimate.com/github/fukuiretu/loose_attr/badges/gpa.svg)](https://codeclimate.com/github/fukuiretu/loose_attr)
[![Test Coverage](https://codeclimate.com/github/fukuiretu/loose_attr/badges/coverage.svg)](https://codeclimate.com/github/fukuiretu/loose_attr/coverage)



## Overview
`LooseAttr` is  [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord) extension module. for the element (column) as defined in the JSON format, can property access.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'loose_attr'
```



## Usage

### Normal

Step1. To prepare the `ext_field` column. Put the data in JSON format to `ext_field`.

```ruby
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:posts) do |t|
      t.string  :body
      t.string  :category
      t.boolean :actived
      t.text    :ext_field
    end
  end
end
```

Step2. To define the `loose_attr` the Model class of ActiceReocrd.

```ruby
class Post < ActiveRecord::Base
  loose_attr :comment_count,   default_value: 1
  loose_attr :user_name,       default_value: 'noname'
  loose_attr(
    :posted_at,
    cast_type: :date,
    default_value: '2016-01-01 00:00:00',
    option: { format: '%Y-%m-%d %H:%M:%S' }
  )
end
```

Step3. Call the property defined in `loose_attr`.

```ruby
Post.create(
  id: 1,
  body: 'hogefoobar',
  category: :it,
  actived: true,
  ext_field: {
    comment_count: 10,
    user_name: nil,
    posted_at: nil
  }.to_json
)

post = Post.find(1)
puts post.body # hogefoobar
puts post.comment_count # 10
puts post.user_name # noname
puts post.posted_at # 2016-01-01 00:00:00
```

### Extra

If you want to `ext_field` to `ext` when, define the `modify_loose_attr_column_name`.

```ruby
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:posts) do |t|
      t.string  :body
      t.string  :category
      t.boolean :actived
      t.text    :ext
    end
  end
end

class Post < ActiveRecord::Base
  modify_loose_attr_column_name 'ext'
  loose_attr :comment_count,   default_value: 1
  loose_attr :user_name,       default_value: 'noname'
  loose_attr(
    :posted_at,
    cast_type: :date,
    default_value: '2016-01-01 00:00:00',
    option: { format: '%Y-%m-%d %H:%M:%S' }
  )
end
```

## loose_attr option property

| Propety        | Required     | Default     | Remarks            |
| :------------- | :------------| :-----------| :------------------|
| default_value  | ×            | -           | hoge |
| cast_type      | ×            | -           | integer OR string OR boolean OR date  |
| option:format  | ×            | -           | cast_type = date only |



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
