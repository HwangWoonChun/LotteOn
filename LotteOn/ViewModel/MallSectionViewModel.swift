//
//  MallSectionViewModel.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/26.
//

import Foundation

struct MallSectionViewModel {
    var mallName: String = ""
    var isSelected: Bool = false

    init(mallInfo: MallInfo) {
        self.mallName = mallInfo.mallName ?? ""
        self.isSelected = mallInfo.mallSelect ?? false
    }
}
