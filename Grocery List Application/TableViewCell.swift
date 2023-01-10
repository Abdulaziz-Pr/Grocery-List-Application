//
//  TableViewCell.swift
//  Grocery List Application
//
//  Created by admin on 1/8/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var subTitle: UILabel!
    
    func setupCell(titleName: String, subTitleEmail: String) {
        title.text = titleName
        subTitle.text = subTitleEmail
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
