require_relative "../sales_commission/defaults"
require_relative "../sales_commission/sales_representative"
require_relative "../sales_commission/personalized_equation"

module SalesCommission
  class Calculator
    attr_accessor :team_rate

    def initialize(total_sales, sales_representatives, team_rates: nil, individual_rates: nil, personalized_equation: nil)
      @total_sales = total_sales
      @sales_representatives = sales_representatives
      @team_rates = team_rates || Defaults::TEAM_RATES
      @individual_rates = individual_rates || Defaults::INDIVIDUAL_RATES
      @personalized_equation = personalized_equation
    end

    def calculate_commissions
      calculate_commissions_for_sales_representatives
    end

    private

    def calculate_commissions_for_sales_representatives
      @sales_representatives.each do |sales_representative|
        sales_representative.commission = personalized_commission_equation(sales_representative)
      end
    end

    def personalized_commission_equation(sales_representative)
      PersonalizedEquation.new(@personalized_equation,
                               sales_representative,
                               calculate_team_rate,
                               calculate_individual_rate(sales_representative.sales),
                               @total_sales).calculate_equation
    end

    def calculate_team_rate
      team_rate ||= @team_rates.find { |range, rate|
        range.cover?(@total_sales)
      }.last
    end

    def calculate_individual_rate(sales)
      @individual_rates.find { |range, rate|
        range.cover?(sales)
      }.last
    end
  end
end
