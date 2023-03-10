class Api::V1::ArticlesController < Api::V1::BaseApiController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    articles = Article.published.order(updated_at: :desc)
    render json: articles, each_serializer: Api::V1::ArticlesPreviewSerializer
  end

  def show
    article = Article.published.find(params[:id])
    render json: article, serializer: Api::V1::ArticlesDetailSerializer
  end

  def create
    article = current_user.articles.create!(article_params)
    render json: article, serializer: Api::V1::ArticlesDetailSerializer
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)
    render json: article, serializer: Api::V1::ArticlesDetailSerializer
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
  end

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
