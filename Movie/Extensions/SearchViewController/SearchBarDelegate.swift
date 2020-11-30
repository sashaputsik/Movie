import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchMovie = searchBar.text else{return}
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        let dateComponents = Calendar.current.dateComponents([.year],
                                                             from: searchMovieYearDatePicker.date)
        let year = dateComponents.year
        Parse.searchMovie(of: searchMovie,
                          year: year) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        searchBar.endEditing(true)
    }
}
