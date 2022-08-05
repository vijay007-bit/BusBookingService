//
//  SeatCell.swift
//  BusBookingService
//
//  Created by MAC on 03/08/22.
//

import UIKit

class SeatCell: UICollectionViewCell {

    @IBOutlet weak var seatSelectionBtn: UIButton!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var seatView: UIView!
    
    var callBackSeatSelected:(()->())?
    
    override func prepareForReuse() {
        callBackSeatSelected = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seatView.TopLeftTopRightCornerRound(radius: 5)
    }
    @IBAction func seatBtnTapped(_ sender: UIButton) {
        callBackSeatSelected?()
    }
    
}
