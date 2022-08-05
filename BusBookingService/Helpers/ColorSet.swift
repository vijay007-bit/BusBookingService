//
//  ColorSet.swift
//  BusBookingService
//
//  Created by MAC on 03/08/22.
//

import Foundation


enum ColorSet{
    case background
    case available
    case booked
    case ladies
    case selected
    public var color: String{
        switch self{
        case .background : return "bgColor"
        case .available : return "availableColor"
        case .booked : return "bookedColor"
        case .ladies : return "ladiesColor"
        case .selected : return "selectedColor"
        }
    }
}


enum ImageAsset{
    case home
    case back
    public var name: String{
        switch self{
        case .home : return "homeIcon"
        case .back : return "arrowBack"
        }
    }
}


enum Cells{
    case header
    case seat
    public var identifier: String{
        switch self{
        case .header : return "headerCell"
        case .seat : return "seatCell"
        }
    }
}


enum Cell{
    case header
    case seat
    public var nib: String{
        switch self{
        case .header : return "HeaderCell"
        case .seat : return "SeatCell"
        }
    }
}
