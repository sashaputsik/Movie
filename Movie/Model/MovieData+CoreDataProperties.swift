import Foundation
import CoreData


extension MovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var voteAverage: Float

}
