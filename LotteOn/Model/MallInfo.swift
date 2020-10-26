//
//  MallInfo.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/26.
//

import Foundation

struct MallInfo {
    let mallName: String?
    var mallSelect: Bool?
    let mallNo: String?
    
    init(mallName: String, mallSelect: Bool, mallNo: String) {
        self.mallName = mallName
        self.mallSelect = mallSelect
        self.mallNo = mallNo
    }
}
