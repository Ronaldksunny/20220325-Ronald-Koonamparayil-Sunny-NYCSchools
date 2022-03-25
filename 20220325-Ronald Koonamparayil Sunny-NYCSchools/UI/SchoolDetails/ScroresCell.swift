//
//  ScroresCell.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import UIKit

class ScoresCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var satReadingAvgScoreLabel: UILabel!
    @IBOutlet var satMathAvgScoreLabel: UILabel!
    @IBOutlet var satWritingAvgScoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
