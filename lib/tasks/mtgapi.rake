require 'mtg_sdk'
require 'time'

def get_and_store(page_number, page_size)
  puts "Getting API Data."
  cards = MTG::Card.where(page: page_number, contains: 'imageUrl').where(pageSize: page_size).all
  puts "API Data Received."

  write_results(cards, nil)
  puts "Done writing batch to db."

  current_page_ids = cards.map { |card_info| card_info.multiverse_id }
end

def write_results(results, duration)
  Card.transaction do
    results.each do |card_info|
      # puts "Writing: #{card_info.multiverse_id} #{card_info.name}"
      Card.write_card_to_database(card_info)
    end
  end
end

# def write_results_fast(results, duration)
#   slices = results.each_slice(20).to_a
#   Parallel.each(slices) do |slice|
#     Card.transaction do
#       slice.each do |card_info|
#         # puts "Writing: #{card_info.multiverse_id} #{card_info.name}"
#         Card.write_card_to_database(card_info)
#       end
#     end
#   end
# end

def is_last_page?(page_size, current_page_ids, previous_page_ids)
  if current_page_ids.count != page_size
    if previous_page_ids.sort == current_page_ids.sort
      return true
    end
  end
  return false
end

REQUEST_RATE = 5000 / 60 / 60
PAGE_SIZE = 100

namespace :mtgapi do
  desc "TODO"
  task import: :environment do |task, args|
    page_number = 0
    last_page = false
    previous_page_ids = []
    until last_page do
      puts "Starting page ##{page_number}"
      t_start = Time.now.to_f

      current_page_ids = get_and_store(page_number, PAGE_SIZE)
      last_page = is_last_page?(PAGE_SIZE, current_page_ids, previous_page_ids)

      previous_page_ids = current_page_ids
      page_number += 1
      t_end = Time.now.to_f

      duration = t_end - t_start
      extra_time = REQUEST_RATE - duration
      if (extra_time) > 0
        puts "Sleeping #{extra_time} seconds"
        sleep(extra_time)
      else
        puts "We spent #{duration} seconds. Wasted: #{-1 * extra_time} seconds"
      end
    end
  end
end
