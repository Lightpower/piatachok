# encoding: utf-8
module Report

  class << self

    ##
    # Report by operations of family. It's grouped by categories and period
    #
    def single(family_id, period, sampling_period)
      # categories for titles
      categories = MoneyOperation.by_period(period).categories_of_family(family_id)
      # data for rows
      sums = MoneyOperation.where(family_id: family_id, created_at: period)
          .group("(current_date - created_at::timestamp::date)/#{sampling_period}")
          .group(:category_id)
          .order("(current_date - created_at::timestamp::date)/#{sampling_period}")
          .order(:category_id)
          .sum(:amount)
      result =  { titles: [], rows: []}
      # titles
      result[:titles] = [{ id: nil, type: nil, name: "Дата"}]
      categories.each {|item| result[:titles] << {id: item.id, type: item.type, name: item.name } }
      #rows
      (sums.keys.map(&:first).uniq || 0).each do |per|
        new_row = %W(#{Time.now.to_date - (per.to_i+1).days})
        categories.each do |category|
          new_row << sums[[per, category.id]]
        end
        result[:rows] << new_row if new_row.compact.size > 1
      end

      result
    end

  end

end