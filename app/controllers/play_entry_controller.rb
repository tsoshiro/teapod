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

    # 入力チェック
    rep = Regexp.new(/^(http|https):\/\/.*$/)
    if !rep.match(url)
      # 再度入力させる
      flash[:danger] = "無効なURLです"
      puts "Invalid URL"
      redirect_to root_path
      return
    end

    @content = get_contents(url)
  end

  # URLから本文抽出
  def get_contents(url = '')
    content = Content.new

    # Case 1. Using WebClip
    body, title = web_clip(url)
    content.body = body
    content.title = title

    # Case 2. Default
    # open(url) do |io|
    #   html = io.read
    #   body,title = ExtractContent.analyse(html)
    #
    #   content.body = body
    #   content.title = title
    # end

    content.url = url
    content
  end

  def web_clip(url)
    # 文字コードを取得
    charset = URI.parse(url).read.charset.to_s.downcase

    # iso-8859-1/何もなしの場合は，誤認識の可能性が高いので，他の文字コードとして処理
    if charset == "iso-8859-1" || charset == ""
    	# 各文字コードの候補に対して本文抽出（各文字コードを試して，例外がでなければそれを標準出力）
    	charset_list = ["rb:utf-8", "rb:Shift_JIS", "rb:eucJP"]
    	charset_list.each do |charset_est|
    		open(url, charset_est) do |io|
    			begin
    				html = io.read.encode("UTF-8")
    				body, title = ExtractContent.analyse(html)
    			rescue
    				next
    			end
    		end
    	end
    else
    	# charsetから，open-uriにおける文字コードに換言
    	charset_hash = {
    		"euc-jp" => "rb:eucJP",
    		"shift_jis" => "rb:Shift_JIS",
    		"shift-jis" => "rb:Shift_JIS",
    		"utf-8"	=> "rb:utf-8"}
    	if charset_hash.has_key?(charset)
    		charset_est = charset_hash[charset]

    		# 本文抽出
    		open(url, charset_est) do |io|
    			html = io.read
    			# ExtractContentがUTF-8しか受け付けないのでエンコード．
    			# ただし，普通に.encode("UTF-8")するとinvalid なバイト列が…と起こられるので，
    			# http://d.hatena.ne.jp/yarb/20110112/p1 に従って一旦UTF-16BEに変換の後にUTF-8に変換．
    			html = html.encode("UTF-16BE", :invalid => :replace, :undef => :replace, :replace => '?').encode("UTF-8")
    			body, title = ExtractContent.analyse(html)
    		end
    	else
    		# 本文抽出
    		open(url) do |io|
    			html = io.read
    			# ExtractContentがUTF-8しか受け付けないのでエンコード．
    			# ただし，普通に.encode("UTF-8")するとinvalid なバイト列が…と起こられるので，
    			# http://d.hatena.ne.jp/yarb/20110112/p1 に従って一旦UTF-16BEに変換の後にUTF-8に変換．
    			html = html.encode("UTF-16BE", :invalid => :replace, :undef => :replace, :replace => '?').encode("UTF-8")
    			body, title = ExtractContent.analyse(html)
    		end
    	end
    end
  end
end
