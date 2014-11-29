require 'rails_helper'

describe RelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "creating a relationship with Ajax" do

# user_relationship_path
# POST	/users/:user_id/relationship(.:format)	relationships#create
# DELETE	/users/:user_id/relationship(.:format)	relationships#destroy

    it "should increment the Relationshop count" do
      expect do
        xhr :post, user_relationship: { user_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, user_relationship: { user_id: other_user.id }
      expect(response).to be_success
    end
  end

    describe "destroying a relationship with Ajax" do

      before { user.follow!(other_user) }
      let(:relationship) do
        user.relationships.find_by(followed_id: other_user.id)
      end

      it "should decrement the Relationship count" do
        expect do
          xhr :delete, :destroy, id: relationship.id
        end.to change(Relationship, :count).by(-1)
      end

      it "should respond with success" do
        xhr :delete, :destroy, id: relationship.id
        expect(response).to be_success
      end
    end

end
