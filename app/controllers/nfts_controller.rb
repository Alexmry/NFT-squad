class NftsController < ApplicationController

  before_action :authenticate_user!, only: [:toggle_favorite, :new]

  def toggle_favorite
    @nft = Nft.find_by(id: params[:id])
    current_user.favorited?(@nft) ? current_user.unfavorite(@nft) : current_user.favorite(@nft)
    # in order to see the like appear we need to refresh
  end

  def toggle_follow
  end

  def liked_nfts
    # @nfts = Nft.where(current_user.favorited?(@nft) == true)
    @liked_nfts1 = []
    @nfts = Nft.all
    @nfts.each do |nft|
      if current_user.favorited?(nft)
        @liked_nfts1 << nft
      end
    end
    @liked_nfts1 = @liked_nfts1[0..2]
  end

  def show
    @nft = Nft.find(params[:id])
    @user = User.find(@nft.user_id)
    @comment = Comment.new
  end

  def new
  end
  
  def new_nft
    idToken = params[:tokenNft]
    if params[:created] == "true"
      create_bool = true
    else
      create_bool = false
    end
    # checking if the nft is a creation or not
    url = "https://metadata.mintable.app/mintable_gasless/#{idToken}"
    response = RestClient.get(url)
    response_json = JSON.parse(response.body)
    nft = Nft.new(
      name: response_json["name"],
      image_url: response_json["image"],
      description: response_json["subtitle"],
      category: response_json["category"],
      user: current_user,
      media_type: "image",
      price: 100,
      creation: create_bool
    )
    if nft.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end
end

#destroy(comment)
#favourites gem
#create
#edit(commnet)

