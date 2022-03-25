//
//  SchoolListCell.swift
//  20220325-Ronald Koonamparayil Sunny-NYCSchools
//

import UIKit

protocol SchoolListCellDelegate: class {
    func didTapCall(index: Int)
    func didTapMap(index:Int)
}

class SchoolListCell: UITableViewCell {
    var index: Int = 0
    weak var delegate: SchoolListCellDelegate?
    @IBOutlet var cardView: UIView!
    @IBOutlet var separatorLine: UIView!
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var schoolAddrLabel: UILabel!
    @IBOutlet var schoolPhoneNumButton: UIButton!
    @IBOutlet var navigateToAddrButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardViewShadows()
        self.schoolPhoneNumButton.layer.cornerRadius = 15
        self.navigateToAddrButton.layer.cornerRadius = 15
    }

    func setupCardViewShadows(){
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }

    @IBAction func didTapMap(_ sender: Any) {
        delegate?.didTapMap(index: index)
    }
    
    @IBAction func didTapPhone(_ sender: Any) {
        delegate?.didTapCall(index: index)
    }

}
