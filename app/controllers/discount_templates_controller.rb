class DiscountTemplatesController < ApplicationController
  # GET /discount_templates
  # GET /discount_templates.xml
  def index
    @discount_templates = DiscountTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @discount_templates }
    end
  end

  # GET /discount_templates/1
  # GET /discount_templates/1.xml
  def show
    @discount_template = DiscountTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @discount_template }
    end
  end

  # GET /discount_templates/new
  # GET /discount_templates/new.xml
  def new
    @discount_template = DiscountTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @discount_template }
    end
  end

  # GET /discount_templates/1/edit
  def edit
    @discount_template = DiscountTemplate.find(params[:id])
  end

  # POST /discount_templates
  # POST /discount_templates.xml
  def create
    @discount_template = DiscountTemplate.new(params[:discount_template])

    respond_to do |format|
      if @discount_template.save
        format.html { redirect_to(@discount_template, :notice => 'Discount template was successfully created.') }
        format.xml  { render :xml => @discount_template, :status => :created, :location => @discount_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @discount_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /discount_templates/1
  # PUT /discount_templates/1.xml
  def update
    @discount_template = DiscountTemplate.find(params[:id])

    respond_to do |format|
      if @discount_template.update_attributes(params[:discount_template])
        format.html { redirect_to(@discount_template, :notice => 'Discount template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @discount_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /discount_templates/1
  # DELETE /discount_templates/1.xml
  def destroy
    @discount_template = DiscountTemplate.find(params[:id])
    @discount_template.destroy

    respond_to do |format|
      format.html { redirect_to(discount_templates_url) }
      format.xml  { head :ok }
    end
  end
end
