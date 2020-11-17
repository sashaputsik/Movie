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
                                                       for: indexPath) as? TableViewCell else{return UITableViewCell()}
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
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OneMovieViewController") as? OneMovieViewController else{return }
        guard let movie = frc?.object(at: indexPath) else{return }
        vc.id = Int(movie.id)
        showDetailViewController(vc,
                                 sender: nil)
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let context = frc?.managedObjectContext
            guard let movie = frc?.object(at: indexPath) else {return }
            context?.delete(movie)
            DataConfig().appDelegate.saveContext()
        }
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}



