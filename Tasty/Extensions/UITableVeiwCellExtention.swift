//
//  UITableVeiwCellExtention.swift
//  Tasty
//
//  Created by Surjit on 17/12/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.y += 5
            frame.origin.x += 10
            frame.size.height -= 5
            frame.size.width -= 20
            self.layer.cornerRadius = 10.0
            super.frame = frame
        }
    }
}
