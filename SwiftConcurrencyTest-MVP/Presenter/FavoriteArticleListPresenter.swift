//
//  FavoriteArticleListPresenter.swift
//  SwiftConcurrencyTest-MVP
//
//  Created by ウルトラ深瀬 on 14/7/22.
//

import Foundation
import Combine

protocol FavoriteArticleListPresentation: AnyObject {
    func showFavoriteArticles(articles: [ArticleEntity], lgtmUsersModelsOfEachArticles: [LgtmUsersModel])
}

class FavoriteArticleListPresenter {
//    private weak var listener: FavoriteArticleListPresenterInterface?
    private weak var view: FavoriteArticleListView?
    private let router: FavoriteArticleListWireframe
    private let articleInterector: ArticleUsecase
    
    private var cancellables = [AnyCancellable]()
    
    
    //MARK: - output（PresenterからListenerの処理を呼び出す）
    //このPresenterのインターフェースに準拠した抽象的なListener（VC）を注入する
//    init(listener: FavoriteArticleListPresenterInterface) {
//        self.listener = listener
//
//        Publishers.CombineLatest(
//            Store.shard.favoriteArticleList,
//            Store.shard.lgtmUsersModelsResponse
//        )
//        .sink { (favoriteArticleList, lgtmUsersModelsResponse) in
//            listener.showFavoriteArticles(articles: favoriteArticleList,
//                                          lgtmUsersModelsOfEachArticles: lgtmUsersModelsResponse ?? [])
//        }.store(in: &cancellables)
//    }
    
    init(view: FavoriteArticleListView,
         router: FavoriteArticleListWireframe,
         articleInterector: ArticleUsecase) {
        self.view = view
        self.router = router
        self.articleInterector = articleInterector
    }
    
}

extension FavoriteArticleListPresenter: FavoriteArticleListPresentation {
    func showFavoriteArticles(articles: [ArticleEntity], lgtmUsersModelsOfEachArticles: [LgtmUsersModel]) {
        
    }
}
