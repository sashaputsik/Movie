import Foundation
import UIKit
//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath) as? TopRatedTableViewCell else{return UITableViewCell()}
        guard let posterPath = movies[indexPath.row].posterPath,
            let voteAverage = movies[indexPath.row].voteAverage,
            let ganreId = movies[indexPath.row].genreIds?.first
                else{return UITableViewCell()}
        
        cell.accessoryView = cell.button
        cell.button.tag = indexPath.row
        cell.posterImageView.image = UIImage(data: Parse.setImage(path: posterPath))
        cell.titleLabel.text = movies[indexPath.row].title
        cell.voteAverageLabel.text = "★ \(voteAverage)"
        cell.genreLabel.text = Parse.genreArray[ganreId]
        return cell
    }
    
    
}

//MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OneMovieViewController") as? OneMovieViewController else{return}
        guard let id = movies[indexPath.row].id else{return}
        vc.id = id
        showDetailViewController(vc,
                                 sender: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
