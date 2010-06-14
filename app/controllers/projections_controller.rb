class ProjectionsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    new
#    @projections = Projection.find(:all, :conditions => ["date > ?", Time.new], :order => 'date ASC')
 
    @projections = Projection.find(:all, :order => 'date ASC')

#   if(session[:start_value])
#      @start_value = session[:start_value].to_i
#    else
      @start_value = 0
#    end
    sum = @start_value
    @projections.each do |p|
      sum = sum + p.value.to_i
      p.sum = sum
    end

  end

  def summary
#    projections = Projection.find(:all, :conditions => ["date > ?", Time.new], :order => 'date ASC')
    projections = Projection.find(:all, :order => 'date ASC')
    
    list = Array.new
    map = Hash.new
    projections.each do |p|
      id = p.date.strftime("%Y-%m")
      month = map[id]
      if(!month)
        month = Projection.new
        month.date = p.date
        month.value = 0
        list << month
        map[id] = month
      end
      month.value += p.value
      
      @months = list

      if(session[:start_value])
        @start_value = session[:start_value].to_i
      else
        @start_value = 0
      end

      sum = @start_value
      @months.each do |m|
        sum = sum + m.value
        m.sum = sum
      end
    end
  end

  def start_value
    session[:start_value] = params[:start_value].to_i
    redirect_to :action => 'index'    
  end

  def show
    @projection = Projection.find(params[:id])
  end

  def new
    @projection = Projection.new
  end

  def create
    @projection = Projection.new(params[:projection])
    if @projection.save
      flash[:notice] = 'Projection was successfully created.'
      redirect_to projections_path
    else
      render :action => 'new'
    end
  end

  def edit
    @projection = Projection.find(params[:id])
  end

  def update
    @projection = Projection.find(params[:id])
    if @projection.update_attributes(params[:projection])
      flash[:notice] = 'Projection was successfully updated.'
      redirect_to projections_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    Projection.destroy(params[:id])
    redirect_to projections_path
  end
end
