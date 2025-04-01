class PodcastsController < ApplicationController
	layout "admin"
	before_action :set_podcast, only: %i[ show edit update destroy ]

	def index
		@podcasts = Podcast.order(created_at: :DESC)
	end

	def new
		@podcast = Podcast.new
	end

	def create
		@podcast = Podcast.new(podcast_params)
		if @podcast.save
		  flash[:success] = "Podcast creado correctamente"	
		  redirect_to podcasts_path
		else
		  flash[:error] = "Hubo un problema al crear el podcast"	
		  render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @podcast.update(podcast_params)
			flash[:success] = "Podcast actualizado correctamente"	
		  redirect_to podcasts_path
		else
			flash[:error] = "Hubo un problema al actualizar el podcast"	
		  render :edit, status: :unprocessable_entity
		end
	end

	def show
	end

	def destroy
		@podcast.destroy
		flash[:success] = "Podcast eliminado"	
		redirect_to podcasts_path
	end

	private
	def podcast_params
		params.expect(podcast: [ :title, :link_to_podcast ])
	end

	def set_podcast
		@podcast = Podcast.find(params[:id])
	end
end
