import Foundation
import CoreData
import UIKit

@objc(MovieData)
public class MovieData: NSManagedObject {

}

class DataConfig{
    lazy var appDelegate: AppDelegate = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return AppDelegate()}
        return appDelegate
    }()
}
