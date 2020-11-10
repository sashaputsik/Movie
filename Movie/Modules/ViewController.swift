import UIKit

class ViewController: UIViewController {
    var tags = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoAlertView: AddedFavoriteAlertView!
    override func viewWillAppear(_ animated: Bool) {
        setHidden(is: true)
        activityIndicator.startAnimating()
        tabBarController?.tabBar.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Parse.setMovie(urlString: topRatedMovieUrl) {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.setHidden(is: false)
            }
        }
    }
   
    func setHidden(is hidden: Bool){
        tableView.isHidden = hidden
        activityIndicator.isHidden = !hidden
    }

    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
    }
}

