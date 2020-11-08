import CoreData
import UIKit

class FavoriteMoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var frc: NSFetchedResultsController<MovieData>?
    
    override func viewWillAppear(_ animated: Bool) {
        setRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setRequest(){
        let context = DataConfig().appDelegate.persistentContainer.viewContext
        guard let entityName = MovieData.entity().name else{return }
        let fetchRequest = NSFetchRequest<MovieData>(entityName: entityName)
        let sortD = NSSortDescriptor(key: "id",
                                     ascending: true)
        fetchRequest.sortDescriptors = [sortD]
        let fetchRC = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                 managedObjectContext: context,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
        fetchRC.delegate = self
        do {
            try fetchRC.performFetch()
            frc = fetchRC
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }

}

extension FavoriteMoviesViewController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}
