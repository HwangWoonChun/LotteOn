//
//  ProductViewModel.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import Foundation

//정렬 기준
enum SortType {
    case rank
    case ascendPrice
    case descendPrice
}

struct ProductListViewModel {
    var productList: [Product]?
    var sortType: SortType = .rank
    
    init(productList: [Product]?) {
        self.productList = productList
    }
}
