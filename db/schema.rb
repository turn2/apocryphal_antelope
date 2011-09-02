# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100510041610) do

  create_table "faqs", :force => true do |t|
    t.string  "question"
    t.string  "answer"
    t.boolean "visible",  :default => false
    t.integer "position"
  end

  create_table "followups", :force => true do |t|
    t.string   "description"
    t.boolean  "complete",        :default => false
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "media_outlet_id"
    t.date     "due_date"
  end

  create_table "media_outlets", :force => true do |t|
    t.string   "media_outlet_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "region_id"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.date     "close_date"
    t.date     "release_date"
    t.text     "comments"
    t.string   "email"
    t.string   "cell_phone"
    t.string   "fax"
    t.string   "other_phone"
    t.string   "media_type"
    t.string   "url"
  end

  create_table "parts", :force => true do |t|
    t.string  "part_name"
    t.integer "quantity"
    t.integer "total_sale_price_in_cents"
    t.string  "part_number"
    t.date    "date_of_sale"
    t.integer "wholesaler_id"
  end

  create_table "photos", :force => true do |t|
    t.integer  "wholesaler_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "plumbers", :force => true do |t|
    t.string   "contact_name"
    t.string   "email"
    t.string   "phone"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
    t.string   "cell_phone"
    t.string   "fax"
    t.string   "other_phone"
    t.integer  "wholesaler_id"
    t.boolean  "exported",       :default => false
  end

  create_table "prospects", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "opted_in",     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "visitor_type"
  end

  create_table "regions", :force => true do |t|
    t.string   "region_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_templates", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.integer "due_week"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "task_template_id"
    t.integer  "wholesaler_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "due_date"
    t.boolean  "complete",         :default => false
    t.string   "title"
    t.string   "description"
  end

  create_table "testimonials", :force => true do |t|
    t.string  "quote"
    t.string  "author"
    t.integer "wholesaler_id"
    t.boolean "visible",       :default => false
    t.integer "position"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wholesaler_id"
    t.string   "role",               :limit => 25
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "water_savings", :force => true do |t|
    t.integer "gallons"
  end

  create_table "wholesalers", :force => true do |t|
    t.string  "wholesaler_name"
    t.string  "contact_name"
    t.string  "email"
    t.string  "phone"
    t.string  "street_address"
    t.string  "city"
    t.string  "state"
    t.string  "postal_code"
    t.date    "event_date"
    t.integer "truck"
    t.string  "owner"
    t.string  "cell_phone"
    t.string  "fax"
    t.string  "other_phone"
    t.integer "region_id"
    t.boolean "completed_certification_sheet", :default => false
    t.string  "as_rep_name"
    t.string  "as_rep_email"
    t.string  "as_rep_phone"
    t.string  "as_rep_cell_phone"
    t.string  "as_rep_fax"
    t.string  "event_start"
    t.string  "event_end"
  end

  create_table "winners", :force => true do |t|
    t.string  "winner_name"
    t.integer "wholesaler_id"
    t.integer "position"
  end

end
