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

ActiveRecord::Schema[7.0].define(version: 2023_05_31_074621) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.boolean "archived", default: false, null: false, comment: "Документ архивирован"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields_sets", force: :cascade do |t|
    t.integer "document_id", null: false
    t.string "designation", comment: "Обозначение стандарта (краткое название)"
    t.string "denomination", comment: "Наименование стандарта (длинное название)"
    t.string "oks_code", comment: "Код ОКС"
    t.string "okpd_code", comment: "Код ОКПД "
    t.string "developer", comment: "Разработчик"
    t.string "replacement_for", comment: "Принят взамен"
    t.string "doc_content_link", comment: "Текст документа"
    t.string "amendments", comment: "Поправки"
    t.text "head_content", comment: "Содержание"
    t.text "key_phrases", comment: "Ключевые слова"
    t.text "key_words", comment: "Ключевые фразы"
    t.date "acceptance_date", comment: "Дата принятия"
    t.date "introduction_date", comment: "Дата введения"
    t.date "desc_update_date", comment: "Дата актуализации описания"
    t.integer "acceptance_level", comment: "Уровень принятия"
    t.integer "activity_status", comment: "Статус активности"
    t.integer "set_type", comment: "Начальный или конечный набор значений"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "references", force: :cascade do |t|
    t.integer "fields_set_id", null: false
    t.integer "referrer_doc_id", null: false
    t.integer "referral_doc_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
