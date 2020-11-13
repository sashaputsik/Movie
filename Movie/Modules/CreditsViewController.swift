import UIKit

class CreditsViewController: UIViewController {
  
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var creditId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 15
        performSelector(inBackground: #selector(setActorsInfo),
                        with: nil)
    }
    
    @objc
    func setActorsInfo(){
        Parse.setActors(fullInfo: true,
                        movie: nil,
                        creditId: creditId)
        DispatchQueue.main.async {
            guard let profilePath = actor?.person?.profile_path,
                let actorName = actor?.person?.name else{return }
            self.profileImageView.image = UIImage(data: Parse.setImage(path: profilePath))
            self.nameLabel.text = actorName
            self.moviesCollectionView.reloadData()
        }
    }
    
}

