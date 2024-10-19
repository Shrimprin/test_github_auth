# frozen_string_literal: true

require 'base64'

class Repository < ApplicationRecord
  belongs_to :user
  has_many :file_items, dependent: :destroy

  def save_with_file_items(client)
    transaction do
      save && save_file_items(client)
    end
  end

  private

  def save_file_items(client, file_path = '')
    files = client.contents(path, path: file_path)
    files.each do |file|
      if file[:type] == 'dir'
        save_file_items(client, file[:path])
      else
        file_name = file[:name]
        file_type = file[:type]
        file_content = client.contents(path, path: file[:path])[:content]

        file_content = Base64.decode64(file_content).force_encoding('UTF-8')
        file_items.create!(repository: self, name: file_name, type: file_type, content: file_content)
      end
    end
  end
end
