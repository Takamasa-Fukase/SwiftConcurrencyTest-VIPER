//
//  ArticleListViewController.swift
//  SwiftConcurrencyTest-MVP
//
//  Created by ウルトラ深瀬 on 8/7/22.
//

import UIKit
import Instantiate
import InstantiateStandard
import PKHUD

class ArticleListViewController: UIViewController, StoryboardInstantiatable {
    private var presenter: Presenter?
    private var articles: [Article] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ArticleCell.reusableIdentifier, bundle: nil), forCellReuseIdentifier: ArticleCell.reusableIdentifier)
        
        //PresenterのListenerに自身を代入
        presenter = Presenter(listener: self)
        presenter?.getAuthorizedUser()
        presenter?.getArticles()
    }

}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reusableIdentifier, for: indexPath) as! ArticleCell
        cell.titleLabel.text = articles[indexPath.row].title
        cell.userNameLabel.text = articles[indexPath.row].user.name
        return cell
    }
}

//PresenterのProtocolに準拠し、各種メソッドが呼び出された時の処理を実装
extension ArticleListViewController: PresenterInterface {
    func authorizedUserResponse(user: AuthorizedUser) {
       
    }
    
    func articlesResponse(articles: [Article]) {
        self.articles = articles
        self.tableView.reloadData()
    }
    
    func errorResponse(error: Error) {
        
    }
    
    func isFetching(_ flag: Bool) {
        flag ? HUD.show(.progress) : HUD.hide()
    }
}
