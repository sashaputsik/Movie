import UIKit

class ViewController: UIViewController,
                      ViewsInterfaceProtocol {
    var tags = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labels: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        setHidden(is: true)
        activityIndicator.startAnimating()
        tabBarController?.tabBar.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Parse.setMovie(urlString: topRatedMovieUrl,
                       complitionHandler: {_ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.setHidden(is: false)
            }
        }, errorComplitionHandler: { error in
            DispatchQueue.main.async {
                guard let statusMessage = error.statusMessage else{return}
                self.present(self.setAlert(message: statusMessage),
                             animated: true,
                             completion: nil)
            }
        })
    }
   
    func setHidden(is hidden: Bool){
        tableView.isHidden = hidden
        labels.isHidden = hidden
        activityIndicator.isHidden = !hidden
    }

    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
    }
}


extension UIViewController{
    func setAlert(message: String) -> UIAlertController{
        let alertControler = UIAlertController(title: "Error",
                                               message: message,
                                               preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Okey",
                                   style: .default,
                                   handler: nil)
        alertControler.addAction(action)
        
        return alertControler
    }
}
