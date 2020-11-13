import Foundation

class Parse{
    
    static let genreArray = [28: "Боевик", 12: "Приключения", 16: "Мультфильм",
                            35: "Комедия", 80: "Криминал", 99: "Документальный",
                            18: "Драма", 10751: "Семейный", 14: "Фэнтези",
                            36: "История", 27: "Ужасы", 10402: "Музыка",
                            9648: "Детектив", 10749: "Мелодрама", 878: "Фантастика",
                            10770: "Телевизионный фильм", 53: "Триллер", 10752: "Военный",
                            37: "Вестерн"]
    
    static func setMovie(urlString: String,
                         complitionHandler: @escaping (Movie?)->()){
        guard let url = URL(string: urlString) else{return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return }
            if urlString.contains("videos") {
                let movie = try? JSONDecoder().decode(Movie.self,
                                                      from: data)
                guard let id = movie?.id else{return }
                Parse.setActors(fullInfo: false,
                                  movie: id,
                                  creditId: nil)
                complitionHandler(movie)
            }else{
                let topMovie = try? JSONDecoder().decode(TopMovie.self,
                                                         from: data)
                guard let results = topMovie?.results else{return }
                topRatedMovies = results
            }
            complitionHandler(nil)
        }.resume()
    }
    
    static func setActors(fullInfo: Bool, movie id: Int?, creditId: String?){
       
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id ?? 0 )/credits?api_key=d3c585cce88b277f42e68ce10aa4358f") else{return }
        guard let fullInfoUrl = URL(string: "https://api.themoviedb.org/3/credit/\(creditId ?? "")?api_key=d3c585cce88b277f42e68ce10aa4358f") else{return }
        print(fullInfoUrl)
        let session = URLSession.shared
        session.dataTask(with: fullInfo ? fullInfoUrl : url) { (data, response, error) in
            guard let data = data else{return }
            if !fullInfo{
                let movieActors = try? JSONDecoder().decode(Actors.self,
                from: data)
                guard let actors = movieActors?.cast else{return }
                movieCredits = actors
            }else{
                let movieActors = try? JSONDecoder().decode(FullActors.self,                from: data)

                
                print(movieActors?.person?.known_for)
                actor = movieActors
            }
        }.resume()
    }
    
    static func setImage(path: String) -> Data{
        let urlString = "https://image.tmdb.org/t/p/w500"+path
        guard let url = URL(string: urlString) else{return Data()}
        guard let data = try? Data(contentsOf: url) else{return Data()}
        return data
    }
    
    static func setVideo(path: String)->URL?{
        let youtube = "https://www.youtube.com/watch?v="
        guard let url = URL(string: youtube+path) else{return nil}
        return url
    }
}
