import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchMovie = searchBar.text else{return}
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        Parse.searchMovie(of: searchMovie,
                          year: nil) {
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
