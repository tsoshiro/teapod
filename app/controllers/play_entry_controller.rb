class PlayEntryController < ApplicationController
  require "open-uri"
  require "bundler/setup"
  require "extractcontent"

  def index
  end

  def home
    get_entry
  end

  def new
    @content = Content.new
  end

  def sample
    arr_var = [
      "http://tnakamura.hatenablog.com/entry/2013/06/29/204726",
      "https://note.mu/knz2g/n/n43e38e89bd05",
      "https://blog.craftz.dog/how-ive-attracted-the-first-500-paid-users-for-my-saas-that-costs-5-mo-4111ddad9f50",
      "https://craftzdog.hateblo.jp/entry/i-spend-most-of-my-revenues-from-my-app-on-self-investment"
    ]

    @arr_cont = []
    arr_var.each do |url|
      @arr_cont << get_contents(url)
    end
  end

  def get_entry
    url = params[:content][:url]
    puts "url is " + url

    # 入力チェック
    # rep = Regexp.new("^(http|https)://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$")
    # if (rep != url)
    #   # 再度入力させる
    #   flash[:danger] = "無効なURLです"
    #   redirect_to root_path
    # end

    @content = get_contents(url)
  end

  # URLから本文抽出
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
