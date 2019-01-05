module PlayEntryHelper
  def get_contents(url = '')
    content = Content.new

    open(url) do |io|
      html = io.read
      body,title = ExtractContent.analyse(html)

      content.body = body
      content.title = title
    end
    content.url = url
    content
  end
end
