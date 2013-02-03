class PagesController < ApplicationController
  layout "popup", :only => [:agreement]
  # 通常画面
  def finish_inactive_sign_up; end
  # Popup画面
  def agreement; end
end