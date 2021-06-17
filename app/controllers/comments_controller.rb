class CommentsController < ApplicationController
  #@ means access varialbe outside method in the view

  def create
    @nft = Nft.find(params[:nft_id])
    # Find the NFT that belongs to a comment using the foreign_key nft_id. (The foreign_key is found in the comments table)
    # Each comment on an NFT has Nft_id. Each NFT has an NFT.id but not necessarily a comment.
    @comment = Comment.new(comment_params)
    # You create an instance with content
    @comment.nft = @nft
    # An instance of comment belongs to an instance of NFT
    @comment.user = current_user
    # The user that created the NFT is the user who is logged in the application
    # And the user is linked by the foreign_key User_id (Comment table)
    if @comment.save
      redirect_to nft_path(@nft, anchor: "comment-#{@comment.id}")
      # Anchor is Using Ajax when the page updates/not reload, it will go to the new instance commnet (@comment.id) we just created in the HTML show page.
      # This can be found by ancoring to the comment.id
      # Around Line 80 show.html.erb
      # in order to see the comment appear we need to refresh
      # AJAX with Remote true and then redirect to refresh
    end
  end

def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @nft = Nft.find(params[:nft_id])
    # We are destroying the comment not the nft (not nft.id) We use the foreign_key to get to the comment table to then destroy (nft_id)
    # rails routes | grep destroy to see how we access the comment.
    # Show.html.erb delte function needs both the @nft and comment to build path.
    redirect_to nft_path(@nft)
end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

# The terms “URI” and “URL” are often used interchangeably,
# but they are not exactly the same.
# A URI is an identifier of a specific resource. Like a page, or book, or a document.
# A URL is special type of identifier that also tells you how to access it, such as HTTPs , FTP , etc.
# URL is a Path/Bridge/Road/Route
