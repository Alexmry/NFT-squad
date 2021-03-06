class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :toggle_favorite ]

  def home
    if params[:nft_category].present?
      array_categories = params[:nft_category].split(" ")
      # :nft_category comes from the hidden field tag in home page
      # view goes to js which render to view which then goes to the controller which goes to the view
      # ["music", "art"]
      @nfts = []
      array_categories.each do |category|
        nfts = Nft.where(category: category)
        nfts.each do |nft|
          @nfts << nft
        end
      end
    else
      @nfts = Nft.all
      # specific nfts based on category otherwise all
    end
    if params[:name].present?
      @users = User.search_by_first_and_last_name(params[:name])
    end
    @categories_nft = %w(music art sport collectibles)
    users = User.all
    @user_suggestions = []
    for i in 0...users.length
      if users[i] != current_user
        @user_suggestions << users[i]
      end
    end
  end

  def toggle_favorites
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
















