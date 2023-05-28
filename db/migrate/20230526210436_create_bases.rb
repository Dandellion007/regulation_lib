class CreateBases < ActiveRecord::Migration[7.0]
  def up
    create_enum :acceptance_level, ['international', 'foreign', 'national', 'interstate', 'organizations']
    # Международный, Иностранный, Национальный, Межгосударственный, Стандарт организации
    create_enum :activity_status, ['active', 'canceled', 'replaced']
    # Действующий, Отменен, Заменен

    create_table :bases do |t|
      t.integer :document_id, null: false

      t.string :designation, comment: 'Обозначение стандарта (краткое название)'
      t.string :denomination, comment: 'Наименование стандарта (длинное название)'
      t.string :oks_code, comment: 'Код ОКС'
      t.string :okpd_code, comment: 'Код ОКПД '
      t.string :developer, comment: 'Разработчик'
      t.string :replacement_for, comment: 'Принят взамен'
      t.string :doc_content_link, comment: 'Текст документа'
      t.string :amendments, comment: 'Поправки'

      t.boolean :archived, comment: 'Документ архивирован', default: false, null: false

      t.text :head_content, comment: 'Содержание'
      t.text :key_phrases, comment: 'Ключевые слова'
      t.text :key_words, comment: 'Ключевые фразы'

      t.date :acceptance_date, comment: 'Дата принятия'
      t.date :introduction_date, comment: 'Дата введения'
      t.date :desc_update_date, comment: 'Дата актуализации описания'

      t.enum :acceptance_level, enum_type: 'acceptance_level', comment: 'Уровень принятия'
      t.enum :activity_status, enum_type: 'activity_status', comment: 'Статус активности'

      t.timestamps
    end
  end

  def down
    drop_table :bases

    execute <<-SQL
      DROP TYPE acceptance_level;
      DROP TYPE activity_status;
    SQL
  end
end

# "normReferences", "Нормативные ссылки"
# active_links
# inactive_links
