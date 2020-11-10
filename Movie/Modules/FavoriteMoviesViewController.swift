import CoreData
import UIKit

class FavoriteMoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
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
        var array = [MovieData]()
        array = try! context.fetch(fetchRequest)
        do {
            try fetchRC.performFetch()
            frc = fetchRC
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    @objc
    private func setUnwind(){
        dismiss(animated: true,
                completion: nil)
    }
}

extension FavoriteMoviesViewController: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
        
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?){
        switch type {
        case .delete:
            guard let indexPath = indexPath else{return }
            tableView.deleteRows(at: [indexPath], with: .left)
        default:
            print(type)
        }
        
    }

}
