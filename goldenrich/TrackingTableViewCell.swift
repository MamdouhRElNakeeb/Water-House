//
//  TrackingTableViewCell.swift
//  goldenrich
//
//  Created by Mamdouh El Nakeeb on 3/28/17.
//  Copyright © 2017 Mamdouh El Nakeeb. All rights reserved.
//

import UIKit

class TrackingTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let borderLayer = CAShapeLayer()
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = dateLabel.frame
        rectShape.position = dateLabel.center
        
        rectShape.path = UIBezierPath(roundedRect: dateLabel.bounds, byRoundingCorners: [.bottomRight , .topLeft], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        borderLayer.path = rectShape.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.lineWidth = 2
        borderLayer.frame = dateLabel.bounds
        dateLabel.layer.addSublayer(borderLayer)
        dateLabel.layer.mask = rectShape
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
