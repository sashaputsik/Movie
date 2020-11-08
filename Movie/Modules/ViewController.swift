import UIKit

class ViewController: UIViewController {
    var tags = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewWillAppear(_ animated: Bool) {
        setHidden(is: true)
        activityIndicator.startAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        guard let vc = unwindSegue.source as? FavoriteMoviesViewController else{return }
        print("back")
    }
}

