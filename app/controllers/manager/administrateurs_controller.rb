module Manager
  class AdministrateursController < Manager::ApplicationController
    def create
      administrateur = current_administration.invite_admin(create_administrateur_params[:email])

      if administrateur.errors.empty?
        flash.notice = "Administrateur créé"
        redirect_to manager_administrateurs_path
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, administrateur),
        }
      end
    end

    def reinvite
      Administrateur.find_inactive_by_id(params[:id]).invite!
      flash.notice = "Invitation renvoyée"
      redirect_to manager_administrateur_path(params[:id])
    end

    private

    def create_administrateur_params
      params.require(:administrateur).permit(:email)
    end
  end
end
