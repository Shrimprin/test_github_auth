# frozen_string_literal: true

class FileItemsController < ApplicationController
  def show
    @file_item = FileItem.find(params[:id])
  end
end
