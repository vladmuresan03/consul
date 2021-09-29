class Debates::VotesComponent < ApplicationComponent
  attr_reader :debate
  delegate :css_classes_for_vote, :current_user, :link_to_verify_account, :user_signed_in?, :votes_percentage, to: :helpers

  def initialize(debate)
    @debate = debate
  end

  private

    def voted_classes
      @voted_classes ||= css_classes_for_vote(debate)
    end

    def can_vote?
      debate.votable_by?(current_user)
    end

    def voted_up?
      current_user&.voted_up_on?(debate)
    end

    def voted_down?
      current_user&.voted_down_on?(debate)
    end

    def organization?
      current_user&.organization?
    end
end
