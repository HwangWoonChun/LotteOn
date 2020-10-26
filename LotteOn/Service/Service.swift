//
//  Service.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import Foundation

struct Service {
    static func loadProductList(completionHandler: @escaping ([Product]?) -> Void) {
        if let path = Bundle.main.path(forResource: "product_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let productList = try decoder.decode([Product].self, from: data)
                completionHandler(productList)
            } catch {
                print(error)
                completionHandler(nil)
            }
        }
    }
}
