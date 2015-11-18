require 'spec_helper'

class Post < ActiveRecord::Base
  loose_attr :hoge
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
end
