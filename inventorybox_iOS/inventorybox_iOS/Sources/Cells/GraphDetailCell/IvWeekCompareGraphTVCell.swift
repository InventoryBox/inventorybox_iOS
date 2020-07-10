//
//  IvWeekCompareGraphTVCell.swift
//  inventorybox_iOS
//
//  Created by 황지은 on 2020/07/09.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit
import Charts

class IvWeekCompareGraphTVCell: UITableViewCell {

    @IBOutlet var yearTextField: UITextField!
    @IBOutlet var monthTextField: UITextField!
    @IBOutlet var weekTextField: UITextField!
    @IBOutlet var secondYearTextField: UITextField!
    @IBOutlet var secondMonthTextField: UITextField!
    @IBOutlet var secondWeekTextField: UITextField!
    @IBOutlet var compareChartView: BarChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func compareBtn(_ sender: UIButton) {
    }
}
