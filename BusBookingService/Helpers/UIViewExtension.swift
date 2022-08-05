//
//  UIViewExtension.swift
//  BusBookingService
//
//  Created by MAC on 03/08/22.
//

import UIKit

extension UIView {
    
    func TopLeftTopRightCornerRound(radius corner: Int){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(corner)
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func TopRightCornerRound(radius corner: Int){
        self.clipsToBounds = true
        self.layer.cornerRadius = CGFloat(corner)
        self.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}


extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
