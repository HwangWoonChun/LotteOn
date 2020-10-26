//
//  Bind.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import UIKit

//의존성을 줄이기 위한 바인드 프로토콜
//각 뷰컨트롤러 혹은 셀 간 뷰모델 전달 용
protocol Bindable {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

extension Bindable where Self: UIViewController {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension Bindable where Self: UICollectionViewCell {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
