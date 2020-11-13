import CoreData
import Foundation

var topRatedMovies = [Movie]()
var movieCredits = [Credits]()
public let topRatedMovieUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=d3c585cce88b277f42e68ce10aa4358f&language=us-US&page=1"

enum CodingKeys: String, CodingKey {
       case popularity
       case poster_path
       case id
       case genre_ids
       case title
       case vote_average
       case videos
       case backdrop_path
       case overview
   }
   

class TopMovie: Codable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Movie]?
}


class Movie: Codable{
    var popularity: Float?
    var posterPath: String?
    var id: Int?
    var genreIds:[Int]?
    var title: String?
    var voteAverage: Float?
    var backdropPath: String?
    var videos: Videos?
    var overview: String?

    func encode(to encoder: Encoder) throws {
        
    }
    
    required init(from decoder: Decoder){
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        popularity = try? container?.decode(Float.self,
                                       forKey: .popularity)
        posterPath = try? container?.decode(String.self,
                                            forKey: .poster_path)
        id = try? container?.decode(Int.self,
                               forKey: .id)
        genreIds = try? container?.decode([Int].self,
                                          forKey: .genre_ids)
        title = try? container?.decode(String.self,
                                       forKey: .title)
        voteAverage = try? container?.decode(Float.self,
                                             forKey: .vote_average)
        videos = try? container?.decode(Videos.self,
                                       forKey: .videos)
        backdropPath = try? container?.decode(String.self,
                                              forKey: .backdrop_path)
        overview = try? container?.decode(String.self,
                                          forKey: .overview)
    }
}

//MARK: Video model
class Videos: Codable{
    var results: [Results]?
}

class Results: Codable{
    var site: String?
    var key: String?
    var name: String?
}


