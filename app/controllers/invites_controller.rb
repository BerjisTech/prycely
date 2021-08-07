# frozen_string_literal: true

class InvitesController < ApplicationController
  before_action :set_invite, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show]

  # GET /invites or /invites.json
  def index
    @invites = Invite.where(user_id: current_user.id).joins(:group).joins(user: :accounts).select('invites.id',
                                                                                                  :first_name, :last_name, :name, :email, :group_id, :group_type, :description, :user_id, :invite_key, :max_redeem, :total_redeemed, :invite_email)
  end

  # GET /invites/1 or /invites/1.json
  def show; end

  # GET /invites/new
  def new
    @invite = Invite.new
    @invite_key = Digest::SHA1.hexdigest("#{DateTime.now}/#{session[:current_group]}")
    @invite_url = "#{root_url}join/#{@invite_key}"
  end

  # GET /invites/1/edit
  def edit; end

  # POST /invites or /invites.json
  def create
    @invite = Invite.new(invite_params)

    @invite.group_id = session[:current_group]
    @invite.user_id = current_user.id
    @invite.total_redeemed = 0

    # render json: @invite

    respond_to do |format|
      if @invite.save
        format.html { redirect_to @invite, notice: 'Invite was successfully created.' }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invites/1 or /invites/1.json
  def update
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @invite, notice: 'Invite was successfully updated.' }
        format.json { render :show, status: :ok, location: @invite }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1 or /invites/1.json
  def destroy
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url, notice: 'Invite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invite
    @invite = Invite.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invite_params
    params.require(:invite).permit(:group_id, :invite_key, :max_redeem, :invite_email, :user_id, :total_redeemed)
  end
end
