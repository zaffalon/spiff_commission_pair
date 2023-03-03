class SalesCommissionCalculator
  def initialize(total_sales, sales_representatives)
    @total_sales = total_sales
    @sales_representatives = sales_representatives
  end

  def calculate_commissions
    if @total_sales < 100_000
      calculate_commissions_for_sales_representatives(0.05, 0.1)
    elsif @total_sales >= 100_000 && @total_sales <= 200_000
      calculate_commissions_for_sales_representatives(0.075, 0.15)
    elsif @total_sales > 200_000
      calculate_commissions_for_sales_representatives(0.1, 0.2)
    end
  end

  private

  def calculate_commissions_for_sales_representatives(individual_rate_1, individual_rate_2)
    @sales_representatives.each do |sales_representative|
      if sales_representative.sales < 10_000
        commission = sales_representative.sales * individual_rate_1
      elsif sales_representative.sales >= 10_000 && sales_representative.sales <= 20_000
        commission = sales_representative.sales * individual_rate_2
      elsif sales_representative.sales > 20_000
        commission = sales_representative.sales * 0.1
      end

      sales_representative.commission = commission
    end
  end
end

class SalesRepresentative
  attr_reader :sales
  attr_accessor :commission

  def initialize(sales)
    @sales = sales
    @commission = 0
  end
end
