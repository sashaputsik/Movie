import CoreData
import Foundation

var movies = [Movie]()
var movieCredits = [Credits]()
public let topRatedMovieUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=d3c585cce88b277f42e68ce10aa4358f&language=ru-RU&page=1"

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


//MARK: Actors model
class Actors: Codable{
    var id: Int?
    var cast: [Credits]?
}

class Credits: Codable{
    var character: String?
    var name: String?
    var profile_path: String?
    
    required init(decoder: Decoder) throws{
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        character = try? container?.decode(String.self, forKey: .character)
        name = try? container?.decode(String.self, forKey: .name )
        profile_path = try? container?.decode(String.self, forKey: .profile_path)
    }
}

class Parse{
    
    static let genreArray = [28: "Боевик", 12: "Приключения", 16: "Мультфильм",
                            35: "Комедия", 80: "Криминал", 99: "Документальный",
                            18: "Драма", 10751: "Семейный", 14: "Фэнтези",
                            36: "История", 27: "Ужасы", 10402: "Музыка",
                            9648: "Детектив", 10749: "Мелодрама", 878: "Фантастика",
                            10770: "Телевизионный фильм", 53: "Триллер", 10752: "Военный",
                            37: "Вестерн"]
    
    static func setMovie(urlString: String, complitionHandler: @escaping (Movie?)->()){
        guard let url = URL(string: urlString) else{return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return }
            if urlString.contains("videos") {
                let movie = try? JSONDecoder().decode(Movie.self,
                                                      from: data)
                guard let id = movie?.id else{return }
                Parse().setActors(movie: id)
                complitionHandler(movie)
            }else{
                let topMovie = try? JSONDecoder().decode(TopMovie.self,
                                                         from: data)
                guard let results = topMovie?.results else{return }
                movies = results
            }
            complitionHandler(nil)
        }.resume()
    }
    
    fileprivate func setActors(movie id: Int){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=d3c585cce88b277f42e68ce10aa4358f") else{return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return }
            let movieActors = try? JSONDecoder().decode(Actors.self,
                                                        from: data)
            guard let actors = movieActors?.cast else{return }
            movieCredits = actors
        }.resume()
    }
    
    static func setImage(path: String) -> Data{
        let urlString = "https://image.tmdb.org/t/p/w500"+path
        guard let url = URL(string: urlString) else{return Data()}
        guard let data = try? Data(contentsOf: url) else{return Data()}
        return data
    }
}
