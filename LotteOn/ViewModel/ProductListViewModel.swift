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
    
    var mallList: [MallInfo] = []
    var productList: [Product]?
    var sortType: SortType = .rank

    //최대 최소값
    var maxPrice: Double = 0
    var minPrice: Double = 0
    
    //사용자가 선택한 최대 최소값
    var selectedMinPrice: Double = 0
    var selectedMaxPrice: Double = 0

    init(productList: [Product]?) {
        
        self.mallList.append(MallInfo(mallName: "롯데 On", mallSelect: true, mallNo: "0"))
        self.mallList.append(MallInfo(mallName: "롯데백화점", mallSelect: true, mallNo: "1"))
        self.mallList.append(MallInfo(mallName: "롯데마트", mallSelect: true, mallNo: "2"))
        self.mallList.append(MallInfo(mallName: "롭스", mallSelect: true, mallNo: "3"))
        
        self.productList = productList
        
        let sorted = productList?.sorted(by: { (product1, product2) -> Bool in
            product1.p ?? 0 > product2.p ?? 0
        })

        self.maxPrice = sorted?.first?.p ?? 0
        self.minPrice = sorted?.last?.p ?? 0
        
        self.selectedMinPrice = self.minPrice
        self.selectedMaxPrice = self.maxPrice
    }
    
    public mutating func reset() {
        //mall reset
        for (index, _) in self.mallList.enumerated() {
            self.mallList[index].mallSelect = true
        }
        //max, min reset
        self.selectedMinPrice = self.minPrice
        self.selectedMaxPrice = self.maxPrice
    }
    
    public func orderBy(sortType: SortType) -> [Product] {
        switch sortType {
        case .rank:
            let productList = self.productList ?? []
            return self.checkSelectedMallList(currentMall: productList)
        case .ascendPrice:
            let productList = self.productList?.sorted(by: { (product1, product2) -> Bool in
                product1.p ?? 0 > product2.p ?? 0
            }) ?? []
            return self.checkSelectedMallList(currentMall: productList)
        case .descendPrice:
            let productList = self.productList?.sorted(by: { (product1, product2) -> Bool in
                product1.p ?? 0 < product2.p ?? 0
            }) ?? []
            return self.checkSelectedMallList(currentMall: productList)
        }
    }
    
    public func filterBy(currentMall: [Product]) -> [Product] {
        return currentMall.filter {
            let price = $0.p ?? 0
            return price >= self.selectedMinPrice && price <= self.selectedMaxPrice
        }
    }
    
    private func checkSelectedMallList(currentMall: [Product]) -> [Product] {
        
        var lotteOn = false
        var depart = false
        var mart = false
        var lohb = false
        
        for (index, mall) in self.mallList.enumerated() {
            if index == 0 { lotteOn = mall.mallSelect ?? false }
            else if index == 1 { depart = mall.mallSelect ?? false }
            else if index == 2 { mart = mall.mallSelect ?? false }
            else if index == 3 { lohb = mall.mallSelect ?? false }
        }

        var filterList: [Product] = currentMall
        
        if lotteOn == false {
            filterList = filterList.filter {
                $0.t != "0"
            }
        }
        
        if depart == false {
            filterList = filterList.filter {
                $0.t != "1"
            }
        }
        
        if mart == false {
            filterList = filterList.filter {
                $0.t != "2"
            }
        }
        
        if lohb == false {
            filterList = filterList.filter {
                $0.t != "3"
            }
        }
        return filterList
    }
}
