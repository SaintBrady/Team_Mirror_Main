import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PillReminder")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}

func loadPlayers() -> [Player] {
    let mainContext = CoreDataManager.shared.mainContext
    let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
    do {
        let results = try mainContext.fetch(fetchRequest)
        return results
    }
    catch {
        debugPrint(error)
    }
}
