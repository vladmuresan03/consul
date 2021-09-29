module VotesHelper
  def debate_percentage_of_likes(debate)
    debate.likes.percent_of(debate.total_votes)
  end

  def votes_percentage(vote, debate)
    return "0%" if debate.total_votes == 0

    if vote == "likes"
      "#{debate_percentage_of_likes(debate)}%"
    elsif vote == "dislikes"
      "#{100 - debate_percentage_of_likes(debate)}%"
    end
  end

  def css_classes_for_vote(votable)
    case current_user&.voted_as_when_voted_for(votable)
    when true
      { against: "no-voted" }
    when false
      { in_favor: "no-voted" }
    else
      {}
    end
  end
end
