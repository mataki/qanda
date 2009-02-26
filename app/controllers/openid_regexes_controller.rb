class OpenidRegexesController < ApplicationController
  # GET /openid_regexes
  # GET /openid_regexes.xml
  def index
    @openid_regexes = OpenidRegex.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @openid_regexes }
    end
  end

  # GET /openid_regexes/1
  # GET /openid_regexes/1.xml
  def show
    @openid_regex = OpenidRegex.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @openid_regex }
    end
  end

  # GET /openid_regexes/new
  # GET /openid_regexes/new.xml
  def new
    @openid_regex = OpenidRegex.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @openid_regex }
    end
  end

  # GET /openid_regexes/1/edit
  def edit
    @openid_regex = OpenidRegex.find(params[:id])
  end

  # POST /openid_regexes
  # POST /openid_regexes.xml
  def create
    @openid_regex = OpenidRegex.new(params[:openid_regex])

    respond_to do |format|
      if @openid_regex.save
        flash[:notice] = 'OpenidRegex was successfully created.'
        format.html { redirect_to(@openid_regex) }
        format.xml  { render :xml => @openid_regex, :status => :created, :location => @openid_regex }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @openid_regex.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /openid_regexes/1
  # PUT /openid_regexes/1.xml
  def update
    @openid_regex = OpenidRegex.find(params[:id])

    respond_to do |format|
      if @openid_regex.update_attributes(params[:openid_regex])
        flash[:notice] = 'OpenidRegex was successfully updated.'
        format.html { redirect_to(@openid_regex) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @openid_regex.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /openid_regexes/1
  # DELETE /openid_regexes/1.xml
  def destroy
    @openid_regex = OpenidRegex.find(params[:id])
    @openid_regex.destroy

    respond_to do |format|
      format.html { redirect_to(openid_regexes_url) }
      format.xml  { head :ok }
    end
  end
end
