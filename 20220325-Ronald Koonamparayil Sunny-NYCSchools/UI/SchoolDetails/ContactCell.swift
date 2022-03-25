//
//  ContactCell.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
