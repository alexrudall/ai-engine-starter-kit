module ApplicationHelper
  def default_meta_tags
    {
      site: "insertrobot.com",
      title: "StoryTeller",
      description: "AI::Engine Example",
      keywords: "ruby, rails, ai",
      separator: "&mdash;".html_safe
    }
  end

  DEFAULT_MARKDOWN_EXTENSIONS = {
    autolink: true,
    fenced_code_blocks: true,
    filter_html: true,
    highlight: true,
    no_intra_emphasis: true,
    prettify: true,
    underline: true
  }.freeze
  def markdown(content, extensions = {})
    extensions = DEFAULT_MARKDOWN_EXTENSIONS.merge(extensions)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions)
    renderer.render(content).html_safe
  end
end
