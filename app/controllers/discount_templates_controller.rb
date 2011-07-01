class DiscountTemplatesController < ApplicationController
  
  around_filter :shopify_session
  
  def index
    @discount_template = DiscountTemplate.new(:starts_at => DateTime.now, :order_placed_after => DateTime.now)
    @discount_templates = DiscountTemplate.all

    respond_to do |format|
      format.html
      format.json do
        render :json => @discount_templates
      end
    end
  end

  def show
    @discount_template = current_shop.discount_templates.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /discount_templates/1/edit
  def edit
    @discount_template = DiscountTemplate.find(params[:id])
    render :layout => nil
  end
  
  def new
    @discount_template = DiscountTemplate.new
  end
  
  # POST /discount_templates
  # POST /discount_templates.xml
  def create
    params[:discount_template][:shop_id] = current_shop.id unless params[:discount_template].nil?
    
    @discount_template = DiscountTemplate.new(params[:discount_template])

    respond_to do |format|
      if @discount_template.save
        format.html { redirect_to(discount_templates_path, :notice => 'Discount template was successfully created.') }
      else
        @discount_templates = DiscountTemplate.all
        format.html { render :action => "index", :error => 'Oops! Please fix the missing or incorrect details' }
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
