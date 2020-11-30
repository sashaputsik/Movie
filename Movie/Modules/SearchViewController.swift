import UIKit

class SearchViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchMovieYearDatePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.isHidden = true
        activityIndicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   
    

}
