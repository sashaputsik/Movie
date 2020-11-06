import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Parse.setMovie(url: url) {
            print(movies.first?.posterPath  )
        }
    }


}

