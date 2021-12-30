class Legislation::Proposals::VotesComponent < ApplicationComponent
  attr_reader :proposal
  delegate :css_classes_for_vote, :current_user, :link_to_verify_account, :user_signed_in?, :votes_percentage, to: :helpers

  def initialize(proposal)
    @proposal = proposal
  end

  private

    def voted_classes
      @voted_classes ||= css_classes_for_vote(proposal)
    end

    def can_vote?
      proposal.votable_by?(current_user)
    end

    def cannot_vote_text
      t("legislation.proposals.not_verified", verify_account: link_to_verify_account) unless can_vote?
    end
end
