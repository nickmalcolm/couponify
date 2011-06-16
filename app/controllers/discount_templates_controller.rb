class DiscountTemplatesController < ApplicationController
  
  def index
    @template = DiscountTemplate.new
    @discount_templates = DiscountTemplate.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @discount_template = DiscountTemplate.find(params[:id])

    respond_to do |format|
      format.html
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
