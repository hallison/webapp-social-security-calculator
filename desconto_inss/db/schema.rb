# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_27_135856) do
  create_table "proponents", force: :cascade do |t|
    t.string "name", null: false
    t.string "document_br_cpf", limit: 11, null: false
    t.date "birth_date", null: false
    t.string "address_public_place"
    t.string "address_number"
    t.string "address_district"
    t.string "address_city"
    t.string "address_state", limit: 2
    t.string "address_postalcode", limit: 8
    t.string "phone_contact", limit: 16
    t.string "phone_reference", limit: 16
    t.integer "salary_gross", null: false
    t.integer "salary_social_contribution"
    t.integer "salary_net"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_br_cpf"], name: "proponents_cpf_unique", unique: true
  end

end
