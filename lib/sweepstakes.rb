class Sweepstakes
  class << self
    def find_entries
      @entries = []
      add_two_entries_for_certified_wholesalers
      add_one_entry_for_each_approved_part
      @entries
    end

    def winners
      find_entries
      randomize_entries.uniq.slice(0,20)
    end

    private

    def add_two_entries_for_certified_wholesalers
      certified_wholesalers.each do |wsaler|
        2.times do
          @entries << wsaler
        end
      end
    end

    def add_one_entry_for_each_approved_part
      Wholesaler.find(:all, :include => :parts).each do |wsaler|
        count = 0
        wsaler.parts.each do |part|
          count += 1
          if count < 51
            @entries << wsaler
          end
        end
      end
    end

    def certified_wholesalers
      Wholesaler.find_all_by_completed_certification_sheet(true)
    end

    def randomize_entries
      @entries.sort_by {rand}
    end
  end
end
