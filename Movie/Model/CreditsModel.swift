import Foundation


var actor: FullActors?

//MARK: Actors model

class Actors: Codable{
    var cast: [Credits]?
    var id: Int?
    
    required init(decoder: Decoder) throws{
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? container?.decode(Int.self, forKey: .id)
        cast = try? container?.decode([Credits].self, forKey: .cast)
    
    }
}

//MARK: Actors model
class FullActors: Codable{
    var media: Movie?
    var media_type: String?
    var id: String?
    var idInt: String?
    var person: Person?
    
    required init(decoder: Decoder) throws{
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        id = try? container?.decode(String.self, forKey: .id)
        idInt = try? container?.decode(String.self, forKey: .id)
        person = try? container?.decode(Person.self, forKey: .person)
        media = try? container?.decode(Movie.self, forKey: .media)
        media_type = try? container?.decode(String.self, forKey: .media_type)
    }
}

class Credits: Codable{
    var character: String?
    var name: String?
    var profile_path: String?
    var credit_id: String?
    
//    required init(decoder: Decoder) throws{
//        let container = try? decoder.container(keyedBy: CodingKeys.self)
//        character = try? container?.decode(String.self,
//                                           forKey: .character)
//        name = try? container?.decode(String.self,
//                                      forKey: .name )
//        profile_path = try? container?.decode(String.self,
//                                              forKey: .profile_path)
//        credit_id = try? container?.decode(String.self,
//                                           forKey: .credit_id)
//    }
}

class Person: Codable{
    var profile_path: String?
    var name: String?
    var known_for: [Movie]?
    var gender: Int?
    required init(decoder: Decoder) throws{
           let container = try? decoder.container(keyedBy: CodingKeys.self)
           name = try? container?.decode(String.self,
                                         forKey: .name )
           profile_path = try? container?.decode(String.self,
                                                 forKey: .profile_path)
        known_for = try? container?.decode([Movie].self, forKey: .known_for)
        gender = try? container?.decode(Int.self, forKey: .gender)
       }
}

