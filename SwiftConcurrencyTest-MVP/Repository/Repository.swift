//
//  Repository.swift
//  SwiftConcurrencyTest-MVP
//
//  Created by ウルトラ深瀬 on 4/7/22.
//

import Foundation
import Combine
import Alamofire

@MainActor
final class Repository {
    private static let store = Store.shard

    static func getArticles() async throws {
        let task = AF.request(QiitaAPI.articles).serializingDecodable([Article].self)
        let response = await task.response
        switch (response.response?.statusCode ?? 0) {
            //200~299を正常系とみなし、それ以外はErrorをthrow
        case 200...299:
            let value = response.value
            print("getArticles success value: \(String(describing: value))")
            //成功レスポンスから取り出した値をStoreに格納
            store.articlesResponseSubject.send(value)
            
            //Alamofireのエラーがあれば返し、なければカスタムエラーを返す
        default:
            guard let afError = response.error else {
                print("getArticles unexpectedServerError")
                throw CustomError.unexpectedServerError
            }
            print("getArticles response error: \(afError)")
            throw afError
        }
    }
}
