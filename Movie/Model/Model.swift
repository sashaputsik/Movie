import CoreData
import Foundation

var movies = [Movie]()
let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=d3c585cce88b277f42e68ce10aa4358f&language=ru-RU&page=1"
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
   
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case poster_path
        case id
        case genre_ids
        case title
        case vote_average
    }
    
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
        genreIds = try? container?.decode([Int].self, forKey: .genre_ids)
        title = try? container?.decode(String.self, forKey: .title)
        voteAverage = try? container?.decode(Float.self, forKey: .vote_average)
        
    }
}





class Parse{
    static func setMovie(url: String, complitionHandler: @escaping ()->()){
        guard let url = URL(string: url) else{return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return }
            let topMovie = try? JSONDecoder().decode(TopMovie.self, from: data)
            guard let results = topMovie?.results else{return }
            movies = results
            complitionHandler()
            print(movies)
        }.resume()
    }
}
