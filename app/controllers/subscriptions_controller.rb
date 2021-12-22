class SubscriptionsController < ApplicationController
  before_action :set_user, :set_locale
  skip_authorization_check

  def edit
  end

  def update
    @user.update!(subscriptions_params)
    redirect_to edit_subscriptions_path(token: @user.subscriptions_token),
                notice: t("flash.actions.save_changes.notice")
  end

  private

    def set_user
      @user = User.find_by(subscriptions_token: params[:token])
    end

    def subscriptions_params
      attributes = [:email_on_comment, :email_on_comment_reply, :email_on_direct_message,
                    :email_digest, :newsletter]
      params.require(:user).permit(*attributes)
    end

    def set_locale
      if @user.locale && I18n.available_locales.include?(@user.locale.to_sym)
        session[:locale] = @user.locale
      end

      session[:locale] ||= I18n.default_locale

      I18n.locale = session[:locale]
    end
end
