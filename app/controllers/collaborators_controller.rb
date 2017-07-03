class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator was added to this wiki."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not added. Please try again."
      render :show
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was deleted."
      redirect_to [@wiki]
    else
      flash[:alert] = "Collaborator couldn't be deleted. Try again."
      redirect_to [@wiki]
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
