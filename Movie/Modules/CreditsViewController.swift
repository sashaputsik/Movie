import UIKit

class CreditsViewController: UIViewController, ViewsInterfaceProtocol {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var creditId = ""
    
    override func viewWillAppear(_ animated: Bool) {
        setHidden(is: false)
        performSelector(inBackground: #selector(setActorsInfo),
                        with: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 15
    }
    
    @objc
    private func setActorsInfo(){
        DispatchQueue.main.async {
            guard let profilePath = actor?.person?.profile_path,
                let actorName = actor?.person?.name else{return }
            self.profileImageView.image = UIImage(data: Parse.setImage(path: profilePath))
            self.nameLabel.text = actorName
            self.moviesCollectionView.reloadData()
            self.setHidden(is: true)
        }
    }
    
    func setHidden(is hidden: Bool) {
        nameLabel.isHidden = !hidden
        profileImageView.isHidden = !hidden
        moviesCollectionView.isHidden = !hidden
    }
    
    
}

