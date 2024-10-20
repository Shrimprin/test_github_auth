# frozen_string_literal: true

module RepositoriesHelper
  def root_file_items(repository)
    repository.file_items.where(parent_id: nil)
  end
end
