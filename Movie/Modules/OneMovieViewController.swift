import CoreData
import UIKit
import SafariServices

class OneMovieViewController: UIViewController {

    var id = 0
    var videoPath = ""
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var setVideoButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        performSelector(inBackground: #selector(setMovie),
                        with: nil)
        actorCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.9
        blurEffectView.frame = backdropImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth,
                                           .flexibleHeight]
        backdropImageView.addSubview(blurEffectView)
        setVideoButton.addTarget(self,
                                 action: #selector(setVideo),
                                 for: .touchUpInside)
        setVideoButton.layer.cornerRadius = setVideoButton.frame.height/2
        setVideoButton.layer.shadowOffset = CGSize(width: 1,
                                                   height: 1)
        setVideoButton.layer.shadowOpacity = 0.8
    }
    
    
    //MARK: Handlers
    @objc
    private func setVideo(){
        guard let videoUrl = Parse.setVideo(path: videoPath) else{return }
        let safariView = SFSafariViewController(url: videoUrl)
        safariView.delegate = self
        present(safariView,
                animated: true,
                completion: nil)
    }
    @objc
    private func setMovie(){
        let movieDetailsUrl = "https://api.themoviedb.org/3/movie/\(id)?api_key=d3c585cce88b277f42e68ce10aa4358f&append_to_response=videos"
        Parse.setMovie(urlString: movieDetailsUrl) { (movie) in
            DispatchQueue.main.async {
                self.actorCollectionView.reloadData()
                guard let backdropPath = movie?.backdropPath,
                    let posterPath = movie?.posterPath,
                    let voteAverage = movie?.voteAverage,
                    let videoPath = movie?.videos?.results?.first?.key  else{return }
                self.backdropImageView.image = UIImage(data: Parse.setImage(path: backdropPath))
                self.posterImageView.image = UIImage(data: Parse.setImage(path: posterPath))
                self.titleLabel.text = movie?.title
                self.overviewTextView.text = movie?.overview
                self.voteAverage.text = "★ \(voteAverage)"
                self.videoPath = videoPath
            }
        }
    }

}

//MARK: SFSafariViewControllerDelegate
extension OneMovieViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true,
                completion: nil)
    }
}
