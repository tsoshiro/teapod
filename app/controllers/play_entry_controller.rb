class PlayEntryController < ApplicationController
  require "open-uri"
  require "bundler/setup"
  require "extractcontent"

  def index
  end

  def home
    arr_var = [
      "http://tnakamura.hatenablog.com/entry/2013/06/29/204726",
      "https://note.mu/knz2g/n/n43e38e89bd05",
      "https://blog.craftz.dog/how-ive-attracted-the-first-500-paid-users-for-my-saas-that-costs-5-mo-4111ddad9f50",
      "https://craftzdog.hateblo.jp/entry/i-spend-most-of-my-revenues-from-my-app-on-self-investment"
    ]

    @arr_cont = []
    arr_var.each do |url|
      @arr_cont << self.class.helpers.get_contents(url)
    end
  end
end
