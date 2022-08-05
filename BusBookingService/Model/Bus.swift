// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bus = try? newJSONDecoder().decode(Bus.self, from: jsonData)

import Foundation

// MARK: - Bus
struct Bus: Codable {
    let status: Bool?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, busName, busBrand, busModelNo: String?
    let busAmenities: [String]?
    let busType, busRegNo: String?
    let buslayoutID: BuslayoutID?
    let finalTotalFare, tax, taxAmount: String?
    let userTotalWalletAmount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case busName = "bus_name"
        case busBrand = "bus_brand"
        case busModelNo = "bus_model_no"
        case busAmenities = "bus_amenities"
        case busType = "bus_type"
        case busRegNo = "bus_reg_no"
        case buslayoutID = "buslayoutId"
        case finalTotalFare = "final_total_fare"
        case tax
        case taxAmount = "tax_amount"
        case userTotalWalletAmount = "user_total_wallet_amount"
    }
}

// MARK: - BuslayoutID
struct BuslayoutID: Codable {
    let id, maxSeats, layout, name: String?
    let combineSeats: [[CombineSeat]]?

    enum CodingKeys: String, CodingKey {
        case id
        case maxSeats = "max_seats"
        case layout, name
        case combineSeats = "combine_seats"
    }
}

// MARK: - CombineSeat
struct CombineSeat: Codable, Equatable {
    let bus: Int?
    let type: TypeEnum?
    let seatNo: String?
    let isLadies: Bool?
    let seatStatus: SeatStatus?

    enum CodingKeys: String, CodingKey {
        case bus, type
        case seatNo = "seat_no"
        case isLadies = "is_ladies"
        case seatStatus = "seat_status"
    }
}

enum SeatStatus: String, Codable {
    case empty = "empty"
}

enum TypeEnum: String, Codable {
    case sleeper = "sleeper"
    case sleeperPink = "sleeper-pink"
}
