class Admin::HomeController < AdminController
    before_action :authenticate_user!
    before_action :check_role # Podendo ser modificado para outros roles dentro do projeto

    def index
    end

    private

    def check_role
        unless current_user.role == 1 # Caso o usuário NÃO seja a role 1(Administrador)
            flash[:alert] = 'Você não tem permissão para acessar essa página. '
            redirect_to root_path
        end
    end
end