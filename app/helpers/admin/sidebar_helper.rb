module Admin::SidebarHelper
  def simple_formatting_sidebar(options = {})
    sidebar_content = []
    sidebar_content << render("admin/editions/govspeak_help", options)
    sidebar_content << render("admin/editions/style_guidance", options)
    raw sidebar_content.join("\n")
  end

  def sidebar_tabs(tabs, options = {})
    tab_tags = tabs.map.with_index do |(id, tab_content), index|
      link_content = case tab_content
                     when String
                       tab_content
                     when Array
                       text = tab_content[0]
                       badge_content = tab_content[1]
                       badge_type = tab_content[2]
                       if badge_content
                         badge_class = badge_type ? "badge badge-#{badge_type}" : "badge"
                         "#{text} #{tag.span(badge_content, class: badge_class)}".html_safe
                       else
                         text
                       end
                     end
      link = tag.a(link_content, href: "##{id}", "data-toggle": "tab")
      tag.li(link, class: (index.zero? ? "active" : nil))
    end
    tag.div(class: ["sidebar tabbable", options[:class]].compact.join(" ")) do
      tag.ul(class: "nav nav-tabs add-bottom-margin") { tab_tags.join.html_safe } +
        tag.div(class: "tab-content") { yield TabPaneState.new(self) }
    end
  end
end
