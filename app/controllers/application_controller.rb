# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from StandardError, with: :internal_server_error

  private

  def not_found
    render 'errors/not_found', status: :not_found
  end

  def unprocessable_entity(exception)
    @error_message = exception.message
    render 'errors/unprocessable_entity', status: :unprocessable_entity
  end

  def internal_server_error
    render 'errors/internal_server_error', status: :internal_server_error
  end
end
