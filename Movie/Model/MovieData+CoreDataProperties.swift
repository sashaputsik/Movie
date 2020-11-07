import Foundation
import CoreData


extension MovieData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var posterPath: String?

}
