module SalesCommission
  class PersonalizedEquation
    attr_reader :team_rate, :individual_rate, :total_sales, :individual_sales

    def initialize(personalized_equation, sales_representative, team_rate, individual_rate, total_sales)
      @personalized_equation = personalized_equation || Defaults::EQUATION_TEMPLATE
      @sales_representative = sales_representative
      @team_rate = team_rate
      @individual_rate = individual_rate
      @total_sales = total_sales
      @individual_sales = sales_representative.sales
    end

    def calculate_equation
      begin
        instance_eval @personalized_equation
      rescue => e
        variable_name = e.message[/`([^']*)'/, 1]
        raise e if variable_name.nil?
        raise ArgumentError, "Invalid equation. #{variable_name} is not defined"
      end
    end
  end
end
