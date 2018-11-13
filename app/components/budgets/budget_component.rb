class Budgets::BudgetComponent < ApplicationComponent
  delegate :wysiwyg, :auto_link_already_sanitized_html, :render_map, to: :helpers
  attr_reader :budget

  def initialize(budget)
    @budget = budget
  end

  private

    def coordinates
      return unless budget.present?

      if budget.publishing_prices_or_later? && budget.investments.selected.any?
        investments = budget.investments.selected
      else
        investments = budget.investments
      end

      MapLocation.where(investment_id: investments).map(&:json_data)
    end

    def geographies_data
      Geography.for_budget(budget).map do |geography|
        {
          outline_points: geography.parsed_outline_points,
          color: geography.color,
          headings: geography.headings.map do |heading|
            helpers.link_to heading.name_with_budget,
              budget_investments_path(heading.budget, params: { heading_id: heading.id })
          end
        }
      end
    end
end
