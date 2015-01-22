class CandidatesController < ApplicationController
  protect_from_forgery except: [:index, :show]

  respond_to :json
  def show
    render_api :candidate => Candidate.find(params[:id]) 
  end

  def index
    render_api :candidates => Candidate.all 
  end
 
end
