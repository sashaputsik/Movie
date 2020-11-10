import Foundation
import UIKit

extension OneMovieViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                                  for: indexPath) as? ActorsCollectionViewCell else{return UICollectionViewCell()}
        guard let profilePath = movieCredits[indexPath.row].profile_path else{return UICollectionViewCell()}
        cell.nameLabel.text = movieCredits[indexPath.row].name
        cell.profileImageView.image = UIImage(data: Parse.setImage(path: profilePath))
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        print(movieCredits.count)
        return movieCredits.count
    }
    
    
}

extension OneMovieViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath,
                                    animated: true)
        print(movieCredits[indexPath.row].credit_id)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170,
                      height: 219)
    }
}
