class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
  end

  def new
    @profile = current_user.build_profile(profile_params)
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)
#     @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save(profile_params)
        message = {notice: 'プロフィールを保存しました。'}
      else
        message = {alert: 'プロフィールの保存に失敗しました。'}
      end
      format.html { redirect_to edit_user_profile_path(current_user, @profile), message }
    end
  end

  def update
    respond_to do |format|
      if @profile.save(profile_params)
        message = {notice: 'プロフィールを保存しました。'}
      else
        message = {alert: 'プロフィールの保存に失敗しました。'}
      end
      format.html { redirect_to edit_user_profile_path(current_user, @profile), message }
    end
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
#       @profile = Profile.find(params[:id])
      @profile = current_user.profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:references, :first_name, :last_name, :website_url, :location, :description, :facebook_id, :linkedin_id, :google_plus_id, :organization)
    end
end
