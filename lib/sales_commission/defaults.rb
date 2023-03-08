module SalesCommission
  class Defaults
    TEAM_RATES = {
      (0..99_999.99) => 0.1,
      (100_000..199_999.99) => 0.15,
      (200_000..Float::INFINITY) => 0.2,
    }

    INDIVIDUAL_RATES = {
      (0..9_999.99) => 0.05,
      (10_000..19_999.99) => 0.075,
      (20_000..Float::INFINITY) => 0.1,
    }

    EQUATION_TEMPLATE = "individual_sales * individual_rate + individual_sales * team_rate"
  end
end
