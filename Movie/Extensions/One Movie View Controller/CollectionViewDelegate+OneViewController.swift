import Foundation
import UIKit

extension OneMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        print(movieCredits.count)
        return movieCredits.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                                  for: indexPath) as? ActorsCollectionViewCell else{return UICollectionViewCell()}
        cell.nameLabel.text = movieCredits[indexPath.row].name
        cell.profileImageView.layer.cornerRadius = 10
        if let profilePath = movieCredits[indexPath.row].profile_path{
            cell.profileImageView.image = UIImage(data: Parse.setImage(path: profilePath))
        }else{
            cell.profileImageView.image = UIImage(named: "user.png")
            cell.profileImageView.contentMode = .scaleAspectFit
        }
      
        return cell
    }
    
}

extension OneMovieViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath,
                                    animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CreditsViewController") as? CreditsViewController else{return}
        guard let creditId = movieCredits[indexPath.row].credit_id else{return }
        vc.creditId = creditId
        Parse.setActors(fullInfo: true,
                        movie: nil,
                        creditId: creditId)
        showDetailViewController(vc,
                                 sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170,
                      height: 219)
    }
}
