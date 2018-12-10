class RecruitmentsController < ApplicationController
  before_action :set_recruitment, only: [:show, :edit, :update, :destroy]

  # GET /recruitments
  # GET /recruitments.json
  def index
    @recruitments = Recruitment.all
  end

  # GET /recruitments/1
  # GET /recruitments/1.json
  def show
  end

  # GET /recruitments/new
  def new
    @recruitment = Recruitment.new
  end

  # GET /recruitments/1/edit
  def edit
  end

  # POST /recruitments
  # POST /recruitments.json
  def create
    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.acc_id = current_account.acc_id#アカウントID
    @recruitment.post_time = Time.now.to_s(:datetime)
    @recruitment.update_time = Time.now.to_s(:datetime)

    respond_to do |format|
      if @recruitment.save
        format.html { redirect_to mains_home_path, notice: 'Recruitment was successfully created.' }
        format.json { render :show, status: :created, location: @recruitment }
      else
        format.html { render mains_home_path }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recruitments/1
  # PATCH/PUT /recruitments/1.json
  def update
    respond_to do |format|
      if @recruitment.update(recruitment_params)
        format.html { redirect_to @recruitment, notice: 'Recruitment was successfully updated.' }
        format.json { render :show, status: :ok, location: @recruitment }
      else
        format.html { render :edit }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruitments/1
  # DELETE /recruitments/1.json
  def destroy
    @recruitment.destroy
    respond_to do |format|
      format.html { redirect_to mains_home_path, notice: 'Recruitment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruitment
      @recruitment = Recruitment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recruitment_params
      params.require(:recruitment).permit(:post_time, :update_time, :acc_id, :chat_id, :resolved,  :ans_com_id, :detail, :title, :integer, :answer, :file_id)
    end
end
