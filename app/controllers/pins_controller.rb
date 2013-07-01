class PinsController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.order("created_at desc").page(params[:page]).per_page(10).search(params[:search])
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pins }
      format.js
    end
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
    @pin = Pin.find(params[:id])
    impressionist @pin
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pin }
    end
  end

  # GET /pins/new
  # GET /pins/new.json
  def new
    @pin = current_user.pins.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pin }
    end
  end

  # GET /pins/1/edit
  def edit
    @pin = current_user.pins.find(params[:id])
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = current_user.pins.new(params[:pin])

    respond_to do |format|
      if @pin.save
        @pin.create_activity :create, owner: current_user
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render json: @pin, status: :created, location: @pin }
      else
        format.html { render action: "new" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pins/1
  # PUT /pins/1.json
  def update
    @pin = current_user.pins.find(params[:id])

    respond_to do |format|
      if @pin.update_attributes(params[:pin])
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin = current_user.pins.find(params[:id])
    @pin.destroy

    respond_to do |format|
      format.html { redirect_to pins_url }
      format.json { head :no_content }
    end
  end

  def vote_for_pin
    @pin = Pin.find(params[:id])
    current_user.vote_for(@pin)
    respond_to do |format|
      format.js
    end
  end

  def buy
    @buy= Pin.buy.order("created_at desc").page(params[:page]).per_page(10).search(params[:search])
    respond_to do |format|
      format.html # buy.html.erb
      format.json { render json: @buy }
      format.js
    end
  end

  def recent
    @recent = Pin.recent.order("created_at desc").page(params[:page]).per_page(10).search(params[:search])
    respond_to do |format|
      format.html # recent.html.erb
      format.json { render json: @recent }
      format.js
    end
  end

  def popular
    @popular = Pin.popular.order("created_at desc").page(params[:page]).per_page(10).search(params[:search])
    respond_to do |format|
      format.html # popular.html.erb
      format.json { render json: @popular  }
      format.js
    end
  end

end


