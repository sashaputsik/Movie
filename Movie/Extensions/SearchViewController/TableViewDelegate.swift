import Foundation
import UIKit


//MARK:UITableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id, for: indexPath) as? TableViewCell else{return UITableViewCell()}
        guard let posterPath = searchMovies[indexPath.row].posterPath,
              let genreId = searchMovies[indexPath.row].genreIds?.first,
              let voteAverage = searchMovies[indexPath.row].voteAverage else{return UITableViewCell()}
        cell.posterImageView.image = UIImage(data: Parse.setImage(path: posterPath))
        cell.titleLabel.text = searchMovies[indexPath.row].title
        cell.genreLabel.text = Parse.genreArray[genreId]
        cell.voteAverageLabel.text = "★ \(voteAverage)"
        return cell
    }
    
    
}

//MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OneMovieViewController") as? OneMovieViewController else{return }
        guard let id = searchMovies[indexPath.row].id else{return }
        
        vc.id = id
        showDetailViewController(vc,
                                 sender: nil)
    }
}
