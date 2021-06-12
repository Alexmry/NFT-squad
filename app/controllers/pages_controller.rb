class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :toggle_favorite ]

  def home
    if params[:nft_category].present?
      @nfts = Nft.where(category: params[:nft_category])
    else 
      @nfts = Nft.all
    end
    if params[:name].present?
      @users = User.search_by_first_and_last_name(params[:name])
    end
    @categories_nft = %w(music art sport cinema)
    users = User.all
    @user_suggestions = []
    for i in 0...users.length
      if users[i] != current_user
        @user_suggestions << users[i]
      end
    end
  end

  def toggle_favorites
    p params
    @nft = Nft.find(params[:nft_id])
    # @nft = Nft.find(params[:id]) links to like_button line 1

    current_user.favorited?(@nft) ? current_user.unfavorite(@nft) : current_user.favorite(@nft)
    # redirect_to root_path(anchor: "nft-index-#{@nft.id}")
    # in order to see the like appear we need to refresh
  end

  def toggle_follows
    @user = User.find(params[:user_id])
    current_user.favorited?(@user) ? current_user.unfavorite(@user) : current_user.favorite(@user)
    # redirect_to root_path(anchor: "follow-#{@user.id}")
  end
end














