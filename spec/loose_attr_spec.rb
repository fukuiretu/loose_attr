require 'spec_helper'

class Post < ActiveRecord::Base
  loose_attr :hoge,   default_value: '1'
  loose_attr :foo,    default_value: '2'
  loose_attr :bar,    default_value: '3'
  loose_attr :str_cast, cast_type: :string
  loose_attr :integer_cast, cast_type: :integer
  loose_attr :boolean_cast, cast_type: :boolean
  loose_attr(
    :date_cast,
    cast_type: :date,
    default_value: '2016-01-01 00:00:00',
    option: { format: '%Y-%m-%d %H:%M:%S' }
  )
end

class Article < ActiveRecord::Base
  loose_attr :hoge,   default_value: '1'
  modify_loose_attr_column_name :ext_field_renamed
end

describe LooseAttr do
  it 'has a version number' do
    expect(LooseAttr::VERSION).not_to be nil
  end

  it 'has loose_attr method' do
    expect(Post.methods.include?(:loose_attr)).to be true
    expect(Post.instance_methods.include?(:hoge)).to be true
    expect(Post.instance_methods.include?(:hoge=)).to be true
  end

  it 'return set attr value' do
    post = Post.new
    post.hoge = 'aaaaa'
    post.foo = 'bbbbb'
    post.bar = 'ccccc'
    post.save!

    expect(post.hoge).to eq('aaaaa')
    expect(post.foo).to eq('bbbbb')
    expect(post.bar).to eq('ccccc')
  end

  it 'return default value' do
    post = Post.new

    expect(post.hoge).to eq('1')
    expect(post.foo).to eq('2')
    expect(post.bar).to eq('3')
  end

  it 'return set attr value' do
    post = Post.new
    post.str_cast = 1
    post.integer_cast = '2'
    post.boolean_cast = 'false'
    post.save!

    expect(post.str_cast).to eq('1')
    expect(post.integer_cast).to eq(2)
    expect(post.boolean_cast).to eq(false)
  end

  it 'return date formated' do
    post = Post.new

    expect(post.date_cast).to eq(DateTime.strptime('2016-01-01 00:00:00', '%Y-%m-%d %H:%M:%S').in_time_zone)
  end

  it 'modified ext' do
    article = Article.new

    expect(Article.method_defined?(:ext_field_renamed)).to eq(true)
    expect(article.hoge).to eq('1')
  end
end
