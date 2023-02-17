//
//  Data.swift
//  BikeDangerAreaAlert
//
//  Created by 심현석 on 2023/02/15.
//

import Foundation

// MARK: - JSONData
struct JSONData: Codable {
    let items: Items
}

// MARK: - Items
struct Items: Codable {
    let item: [Item]
}

// MARK: - Item
struct Item: Codable {
    let address: String
    let accidentCount, injuryCount, deathCount: Int
    let lng, lat: String

    enum CodingKeys: String, CodingKey {
        case address = "spot_nm"
        case accidentCount = "occrrnc_cnt"
        case injuryCount = "caslt_cnt"
        case deathCount = "dth_dnv_cnt"
        case lng = "lo_crd"
        case lat = "la_crd"
    }
}

