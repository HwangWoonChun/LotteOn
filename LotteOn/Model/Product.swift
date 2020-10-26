//
//  Product.swift
//  LotteOn
//
//  Created by mmxsound on 2020/10/25.
//

import Foundation

struct Product : Codable {
    let t: String?
    let o: String?
    let n: String?
    let b: String?
    let i: String?
    let op: Double?
    let p: Double?
    let d: Double?
    
    enum CodingKeys: String, CodingKey {
        case t = "t"
        case o = "o"
        case n = "n"
        case b = "b"
        case i = "i"
        case op = "op"
        case p = "p"
        case d = "d"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        t = try values.decodeIfPresent(String.self, forKey: .t)
        o = try values.decodeIfPresent(String.self, forKey: .o)
        n = try values.decodeIfPresent(String.self, forKey: .n)
        b = try values.decodeIfPresent(String.self, forKey: .b)
        i = try values.decodeIfPresent(String.self, forKey: .i)
        op = try values.decodeIfPresent(Double.self, forKey: .op)
        p = try values.decodeIfPresent(Double.self, forKey: .p)
        d = try values.decodeIfPresent(Double.self, forKey: .d)
    }
}
