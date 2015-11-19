require 'spec_helper'

class Post < ActiveRecord::Base
  loose_attr :hoge, default_value: '1'
  loose_attr :foo,  default_value: '2'
  loose_attr :bar,  default_value: '3'
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
end
