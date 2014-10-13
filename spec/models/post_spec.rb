# -*- encoding: utf-8 -*-

require 'rails_helper'

describe Post do

  # TODO auto-generated
  describe '#tagged_with' do
    it 'works' do
      name = double('name')
      result = Post.tagged_with(name)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#from_users_followed_by' do
    it 'works' do
      user = double('user')
      result = Post.from_users_followed_by(user)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#from_tags_followed_by' do
    it 'works' do
      user = double('user')
      result = Post.from_tags_followed_by(user)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#feed' do
    it 'works' do
      user = double('user')
      result = Post.feed(user)
      expect(result).not_to be_nil
    end
  end

end
