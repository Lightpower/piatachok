# encoding: utf-8
module Report

  class << self

    ##
    # Report by operations of family. It's grouped by categories and period
    #
    def single(family_id, period, sampling_period)
      # categories for titles
      categories = MoneyOperation.where(family_id: family_id, created_at: period)
        .joins("INNER JOIN categories ON(operations.category_id = categories.id)")
        .order("categories.type desc, categories.id")
        .select("categories.id, categories.name, categories.type").uniq
      # data for rows
      sums = MoneyOperation.where(family_id: family_id, created_at: period)
          .group("(current_date - created_at::timestamp::date)/#{sampling_period}")
          .group(:category_id)
          .order("(current_date - created_at::timestamp::date)/#{sampling_period}")
          .order(:category_id)
          .sum(:amount)
      result =  { titles: [], rows: []}
      # titles
      result[:titles] = [{ type: nil, name: "Дата"}]
      categories.each {|item| result[:titles] << {type: item.type, name: item.name } }
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