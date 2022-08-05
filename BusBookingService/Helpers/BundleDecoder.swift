//
//  BundleDecoder.swift
//  BusBookingService
//
//  Created by MAC on 03/08/22.
//

import Foundation

struct BundleDecoder{
    static func decodeBusBundleJson() -> Bus{
        let landmarkJson = Bundle.main.path(forResource: "busData", ofType: "json")
        let landmark = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode(Bus.self, from: landmark)
    }
}
