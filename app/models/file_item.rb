# frozen_string_literal: true

class FileItem < ApplicationRecord
  self.inheritance_column = nil # typeカラムを使うために単一テーブル継承を無効にする

  belongs_to :repository
end
