class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  helper_method :current_trainer

  def current_trainer
    @current_trainer ||= Trainer.where(name: "Ash Ketchum").first_or_create
  end
end
