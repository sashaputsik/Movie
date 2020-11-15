import Foundation
import UIKit

//MARK:UICollectionViewDataSource
extension CreditsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let movies = actor?.person?.known_for else{return 0}
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
                                                            for: indexPath) as? ActorsCollectionViewCell else{return UICollectionViewCell()}
        guard let movies = actor?.person?.known_for else{return UICollectionViewCell()}
        guard let posterPath = movies[indexPath.row].posterPath else{return UICollectionViewCell()}
        cell.profileImageView.image = UIImage(data: Parse.setImage(path: posterPath))
        cell.profileImageView.layer.cornerRadius = 10
        return cell
    }
    
    
}

//MARK: UICollectionViewDelegate
extension CreditsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OneMovieViewController") as? OneMovieViewController else{return }
        guard let movies = actor?.person?.known_for else{return}
        guard let id = movies[indexPath.row].id else{return }
        vc.id = id
        showDetailViewController(vc,
                                 sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180,
                      height: 250)
    }
}
