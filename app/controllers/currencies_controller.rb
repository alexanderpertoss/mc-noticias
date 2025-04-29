class CurrenciesController < ApplicationController
  before_action :set_currency, only: %i[ show edit update destroy ]
  before_action :set_global_attributes
  layout "admin"

  # GET /currencies or /currencies.json
  def index
    @currencies = Currency.all
  end

  # GET /currencies/1 or /currencies/1.json
  def show
  end

  # GET /currencies/new
  def new
    @currency = Currency.new
  end

  # GET /currencies/1/edit
  def edit
  end

  # POST /currencies or /currencies.json
  def create
    @currency = Currency.new(currency_params)

    respond_to do |format|
      if @currency.save
        format.html { redirect_to @currency, notice: "Currency was successfully created." }
        format.json { render :show, status: :created, location: @currency }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currencies/1 or /currencies/1.json
  def update
    respond_to do |format|
      if @currency.update(currency_params)
        format.html { redirect_to edit_currency_path(@currency), notice: "Datos actualizados." }
        format.json { render :show, status: :ok, location: @currency }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1 or /currencies/1.json
  def destroy
    @currency.destroy!

    respond_to do |format|
      format.html { redirect_to currencies_path, status: :see_other, notice: "Currency was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def currency_params
      params.expect(currency: [ :official_dolar_purchase, :official_dolar_sell, :blue_dollar ])
    end
    def set_global_attributes
      # Get all the available categories, which excludes multimedia, gente que hace notica and ultimo momento
      @available_categories = Category.available_categories
      @categories = Category.order(queue_position: :desc)

      @trending_articles = Article.trending.limit(3)
      @other_articles = Article.regular_articles(@available_categories).limit(4)  

      # Gente que hace noticia category
      @people_articles = Article.people_news

      @small_ad = Ad.small_ad
      @lateral_ad = Ad.lateral_ad
      @bottom_ad = Ad.bottom_ad
      @podcast_ad = Ad.podcast_ad
    end
end
