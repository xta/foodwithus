module ApplicationHelper

  def public_page?
    params[:controller]=="pages"
  end

end
