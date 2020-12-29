class SubscriptionsController < ApplicationController
  before_action :set_user
  skip_authorization_check

  def edit
  end

  private

    def set_user
      @user = User.find_by(subscriptions_token: params[:token])
    end
end
