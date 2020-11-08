import Foundation
import UIKit


//MARK: UITableViewDataSource{
extension FavoriteMoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let sections = frc?.sections else{return 0}
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id,
                                                       for: indexPath) as? TopRatedTableViewCell else{return UITableViewCell()}
        guard let movie = frc?.object(at: indexPath) else{return UITableViewCell()}
        guard let posterPath = movie.posterPath else{return UITableViewCell()}
        cell.titleLabel.text = movie.title
        cell.posterImageView.image = UIImage(data: Parse.setImage(path: posterPath))
        cell.genreLabel.text = ""
        cell.voteAverageLabel.text = "★ \(movie.voteAverage)"
        cell.setFavoriteButton.isHidden = true  
        return cell
    }
    
    
}

//MARK: UITableViewDelegate
extension FavoriteMoviesViewController: UITableViewDelegate{
}



