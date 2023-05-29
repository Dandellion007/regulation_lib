class CreateFieldsSets < ActiveRecord::Migration[7.0]
  def up
    create_table :fields_sets do |t|
      t.integer :document_id, null: false
      t.string :designation, comment: 'Обозначение стандарта (краткое название)'
      t.string :denomination, comment: 'Наименование стандарта (длинное название)'
      t.string :oks_code, comment: 'Код ОКС'
      t.string :okpd_code, comment: 'Код ОКПД '
      t.string :developer, comment: 'Разработчик'
      t.string :replacement_for, comment: 'Принят взамен'
      t.string :doc_content_link, comment: 'Текст документа'
      t.string :amendments, comment: 'Поправки'
      t.text :head_content, comment: 'Содержание'
      t.text :key_phrases, comment: 'Ключевые слова'
      t.text :key_words, comment: 'Ключевые фразы'
      t.date :acceptance_date, comment: 'Дата принятия'
      t.date :introduction_date, comment: 'Дата введения'
      t.date :desc_update_date, comment: 'Дата актуализации описания'
      t.integer :acceptance_level, comment: 'Уровень принятия'
      t.integer :activity_status, comment: 'Статус активности'
      t.integer :set_type, comment: 'Начальный или конечный набор значений'
      t.timestamps
    end
  end

  def down
    drop_table :fields_sets

    execute <<-SQL
      DROP TYPE IF EXISTS acceptance_level;
      DROP TYPE IF EXISTS activity_status;
      DROP TYPE IF EXISTS set_type;
    SQL
  end
end
