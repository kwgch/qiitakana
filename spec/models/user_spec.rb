# -*- encoding: utf-8 -*-

require 'rails_helper'

describe User do

  # TODO auto-generated
  describe '#find_first_by_auth_conditions' do
    it 'works' do
      warden_conditions = double('warden_conditions')
      result = User.find_first_by_auth_conditions(warden_conditions)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#to_param' do
    it 'works' do
      user = User.new
      result = user.to_param
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#create_user_auth' do
    it 'works' do
      user = User.new
      result = user.create_user_auth
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#create_profile' do
    it 'works' do
      user = User.new
      result = user.create_profile
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#feed' do
    it 'works' do
      user = User.new
      result = user.feed
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#following?' do
    it 'works' do
      user = User.new
      other_user = double('other_user')
      result = user.following?(other_user)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#follow!' do
    it 'works' do
      user = User.new
      other_user = double('other_user')
      result = user.follow!(other_user)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#unfollow!' do
    it 'works' do
      user = User.new
      other_user = double('other_user')
      result = user.unfollow!(other_user)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#tag_following?' do
    it 'works' do
      user = User.new
      tag = double('tag')
      result = user.tag_following?(tag)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#tag_follow!' do
    it 'works' do
      user = User.new
      tag = double('tag')
      result = user.tag_follow!(tag)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#tag_unfollow!' do
    it 'works' do
      user = User.new
      tag = double('tag')
      result = user.tag_unfollow!(tag)
      expect(result).not_to be_nil
    end
  end

end
