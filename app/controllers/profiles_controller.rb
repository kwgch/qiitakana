class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)
    post_processing_of @profile.save(profile_params)
  end

  def update
    post_processing_of @profile.update(profile_params)
  end
  
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
    end
  end

  private

    def set_profile
      @profile = current_user.profile
    end

    def profile_params
      params.require(:profile).permit(:references, :first_name, :last_name, :website_url, :location, :description, :facebook_id, :linkedin_id, :google_plus_id, :organization)
    end
  
  def post_processing_of(success)
    if success
      message = {notice: 'プロフィールを保存しました。'}
    else
      message = {alert: 'プロフィールの保存に失敗しました。'}
    end
    redirect_to edit_user_profile_path(current_user, @profile), message
  end
end
