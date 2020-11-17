import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var setFavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFavoriteButton.layer.shadowOffset = CGSize(width: 1,
                                                      height: 1)
        setFavoriteButton.layer.shadowOpacity = 0.6
        setFavoriteButton.layer.shadowColor = UIColor.lightGray.cgColor
        
        posterImageView.layer.mask = setConfig(10,
                                               roundingCorners: [.topLeft,
                                                                     .bottomRight],
                                               viewBounds: posterImageView.bounds)
        setFavoriteButton.layer.mask = setConfig(5,
                                      roundingCorners: [.topLeft,
                                                           .bottomLeft],
                                      viewBounds: setFavoriteButton.bounds)
        setFavoriteButton.addTarget(self,
                         action: #selector(ss),
                         for: .touchUpInside)
    }
    
    @objc
    func ss(){
        let context = DataConfig().appDelegate.persistentContainer.viewContext
        let movie = MovieData(context: context)
        guard let movieId = topRatedMovies[setFavoriteButton.tag].id,
            let posterPath = topRatedMovies[setFavoriteButton.tag].posterPath,
            let title = topRatedMovies[setFavoriteButton.tag].title,
            let voteAverage = topRatedMovies[setFavoriteButton.tag].voteAverage else{return }
        movie.id = Int64(movieId)
        movie.posterPath = posterPath
        movie.title = title
        movie.voteAverage = voteAverage
        print(voteAverage)
        context.insert(movie)
        DataConfig().appDelegate.saveContext()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func setConfig(_ valueToCorner: Int,
                   roundingCorners: UIRectCorner,
                   viewBounds: CGRect)-> CAShapeLayer{
        posterImageView.layer.cornerRadius = 0
        let bezier = UIBezierPath(roundedRect: viewBounds,
                                  byRoundingCorners: roundingCorners,
                                  cornerRadii: CGSize(width: valueToCorner,
                                                      height: 0))
        let mask = CAShapeLayer()
        mask.path = bezier.cgPath
        
        return mask
    }

}
