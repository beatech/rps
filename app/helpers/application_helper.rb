module ApplicationHelper
  def tab_class(playtype)
    if playtype == "SP"
      'tab-pane active'
    else
      'tab-pane'
    end
  end
end
