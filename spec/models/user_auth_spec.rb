# -*- encoding: utf-8 -*-

require 'rails_helper'

describe UserAuth do

  # TODO auto-generated
  describe '#registered?' do
    it 'works' do
      user_id = double('user_id')
      provider = double('provider')
      result = UserAuth.registered?(user_id, provider)
      expect(result).not_to be_nil
    end
  end

end
