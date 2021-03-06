module ApplicationHelper
  def link_to_main_page
    path = current_user ? user_path(current_user.login_name) : home_path
    content_tag(:a, image_tag("booklog-logo-home.png", class: 'w-1 h-1'),
                href: path)
  end

  def shallow_args(parent, child)
    child.try(:new_record?) ? [parent, child] : child
  end

  def form_action(object)
    return "Create New #{object.model_name.human}" unless object.persisted?
    "Edit #{object.model_name.human}"
  end

  def flash_type(type)
    types = { notice: "bg-info", alert: "bg-danger", success: "bg-success",
              welcome: "bg-olive", warning: "bg-warning" }
    types[type.to_sym]
  end

  def flash_icon_type(type)
    types = { notice: "fas fa-info", warning: "fas fa-exclamation-triangle",
              success: "fas fa-check", welcome: "fab fa-ello",
              alert: "fas fa-exclamation" }
    types[type.to_sym]
  end

  def selected_icon(selected)
    content_tag(:i, "", class: "fas fa-check") if selected
  end

  def random_badge_bg_color
    colors = %w'fuchsia success navy warning primary red indigo olive orange yellow'
    "badge bg-#{colors.shuffle.first}"
  end

  def avatar_files
    files = Dir["app/assets/images/avatars/*"]
    files.each { |e| e.slice!("app/assets/images/avatars/") }
    files.each { |e| e.slice!(".png") }
  end
end
