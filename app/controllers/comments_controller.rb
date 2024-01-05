class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @product = Product.find(params[:product_id])
        @comment = @product.comments.build(comment_params)
        @comment.user = current_user

        redirect_to root_path, notice: 'You not can comment in your product, sorry!' if current_user == @product.id

        if @comment.save
            if @comment.save
                create_activity_log(:created_commentary, @commentary, details: { message: 'Comentário criado' } )
                redirect_to @product, notice: 'Comentário feito.'
            else
                redirect_to @product, alert: 'Erro ao fazer o comentário, tente novamente.'
            end
        end
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def destroy
        @product = Product.find_by(id: params[:product_id])

        if @product
            @comment = @product.comments.find(params[:id])
            if @comment
                @comment.destroy
                redirect_to @product, notice: 'Comment deleted'
            else
                redirect_to @product, notice: 'Not find the comment, try again'
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end

    def create_activity_log(action, trackable, details: {})
        ActivityLog.create( user: current_user, action: action, trackable: trackable, details: details )
    end
end
