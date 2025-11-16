class TweetsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    def index
        @tweets = Tweet.all
    end
    def new
    @tweet = Tweet.new
    end

  def create
    tweet = Tweet.new(tweet_params)
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end
 
  
  private
  def tweet_params
    params.require(:tweet).permit(:kion, :review,:image )
  end
end

