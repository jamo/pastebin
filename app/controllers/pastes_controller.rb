class PastesController < ApplicationController
  skip_before_filter :authenticate_user, :only => [ :new, :create, :show]
  skip_before_filter :can_access? , :only => [:new, :create, :show]
  # GET /pastes
  # GET /pastes.json
 
=begin
  avail = :'c++'       => :cpp,
      :cplusplus   => :cpp,
      :ecmascript  => :java_script,
      :ecma_script => :java_script,
      :rhtml       => :erb,
      :eruby       => :erb,
      :irb         => :ruby,
      :javascript  => :java_script,
      :js          => :java_script,
      :pascal      => :delphi,
      :patch       => :diff,
      :plain       => :text,
      :plaintext   => :text,
      :xhtml       => :html,
      :yml         =>:text
=end  
  def index
    @pastes = Paste.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pastes }
    end

  end

  # GET /pastes/1
  # GET /pastes/1.json
  def show
    
   # @paste = Paste.find(params[:id])
    @paste = Paste.find_by_key(params[:id])# unless @paste
    
    hilight = Paste::LANG[@paste.encoding] || 'java' 
    rivinumerointi = true
    
    @paste.body.each_line do |l|
      rivinumerointi = false if l.length > 80
    end
    if rivinumerointi
      @html = CodeRay.scan(@paste.body, hilight.to_sym).div(:line_numbers => :table)
    else
      @html = CodeRay.scan(@paste.body, hilight.to_sym).div
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paste }
    end
  end

  # GET /pastes/new
  # GET /pastes/new.json
  def new
    @paste = Paste.new
    
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paste }
    end
  end

  # GET /pastes/1/edit
  def edit
    @paste = Paste.find_by_key(params[:id])
  end

  # POST /pastes
  # POST /pastes.json
  def create
    @paste = Paste.new(params[:paste])
    

    respond_to do |format|
      if @paste.save
        format.html { redirect_to paste_path(@paste.key), notice: 'Paste created! You can give the address 
                        of this page to others.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /pastes/1
  # PUT /pastes/1.json
  def update
    @paste = Paste.find(params[:id])

    respond_to do |format|
      if @paste.update_attributes(params[:paste])
        format.html { redirect_to  paste_path(@paste.key), notice: 'Paste was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paste.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pastes/1
  # DELETE /pastes/1.json
  def destroy
    @paste = Paste.find_by_key(params[:id])
    @paste.destroy

    respond_to do |format|
      format.html { redirect_to pastes_url }
      format.json { head :no_content }
    end
  end
end
