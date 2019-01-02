class PlayEntryController < ApplicationController
  require "open-uri"
  require "bundler/setup"
  require "extractcontent"

  def index
  end

  def home
    # test_url = "http://tnakamura.hatenablog.com/entry/2013/06/29/204726"
    # test_url = "https://note.mu/knz2g/n/n43e38e89bd05"
    # @test_url = "https://blog.craftz.dog/how-ive-attracted-the-first-500-paid-users-for-my-saas-that-costs-5-mo-4111ddad9f50"
    # @test_url = "https://craftzdog.hateblo.jp/entry/i-spend-most-of-my-revenues-from-my-app-on-self-investment"
    @test_url = "https://craftzdog.hateblo.jp/entry/healing-atopic-without-steroids"

    open(@test_url) do |io|
      html = io.read
      @body, @title = ExtractContent.analyse(html)
      puts @title
      puts @body
    end
  end
end
