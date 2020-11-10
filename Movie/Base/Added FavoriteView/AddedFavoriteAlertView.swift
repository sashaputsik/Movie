import UIKit

@IBDesignable
class AddedFavoriteAlertView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNIB()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNIB()
    }
    
    func loadNIB(){
        let view = Bundle.main.loadNibNamed("AddedFavoriteAlertView",
                                            owner: self,
                                            options: [:])![0] as! UIView
        view.bounds = bounds
        addSubview(view)
    }
    
}
