import UIKit

class TopRatedTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.mask = setConfig(10,
                                               roundingCorners: [.topLeft,
                                                                     .bottomRight],
                                               viewBounds: posterImageView.bounds)
        button.layer.mask = setConfig(5,
                                      roundingCorners: [.topLeft,
                                                           .bottomLeft],
                                      viewBounds: button.bounds)
        button.addTarget(self,
                         action: #selector(ss),
                         for: .touchUpInside)
    }
    
    @objc
    func ss(){
        print(button.tag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func setConfig(_ valueToCorner: Int,
                   roundingCorners: UIRectCorner,
                   viewBounds: CGRect)-> CAShapeLayer{
        posterImageView.layer.cornerRadius = 0
        let bezier = UIBezierPath(roundedRect: viewBounds,
                                  byRoundingCorners: roundingCorners,
                                  cornerRadii: CGSize(width: valueToCorner,
                                                      height: 0))
        let mask = CAShapeLayer()
        mask.path = bezier.cgPath
        
        return mask
    }

}
