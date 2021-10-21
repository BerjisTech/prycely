# frozen_string_literal: true

# This migration comes from action_text (originally 20180528164100)
class CreateActionTextTables < ActiveRecord::Migration[6.0]
  def change
    execute 'DROP TABLE active_storage_blobs CASCADE'
    execute 'DROP TABLE active_storage_attachments CASCADE'
    execute 'DROP TABLE active_storage_variant_records CASCADE'

    create_table :active_storage_blobs, id: :uuid do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments, id: :uuid do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false, type: :uuid
      t.references :blob,     null: false, type: :uuid

      t.datetime :created_at, null: false

      t.index %i[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                      unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end

    create_table :active_storage_variant_records, id: :uuid do |t|
      t.belongs_to :blob, null: false, index: false, type: :uuid
      t.string :variation_digest, null: false

      t.index %i[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end

    create_table :action_text_rich_texts, id: :uuid do |t|
      t.string     :name, null: false
      t.text       :body, size: :long
      t.references :record, null: false, polymorphic: true, index: false, type: :uuid

      t.timestamps

      t.index %i[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
    end
  end
end
