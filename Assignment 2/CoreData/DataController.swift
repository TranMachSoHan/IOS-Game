/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 19/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
    https://stackoverflow.com/questions/56453857/how-to-save-existing-objects-to-core-data
*/

import CoreData

//write a small initializer for DataController that loads stored data immediately
class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreData")

    init() {
        // If things go wrong – unlikely, but not impossible – we’ll print a message to the Xcode debug log.
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Can't load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Successfully save data!")
        } catch {
            print("Can't save data")
        }
    }
    
    func addPlayer(name: String, pass: String, context: NSManagedObjectContext) -> Player {
        let player = Player(context: context)
        player.id = UUID()
        player.name = name
        player.password = pass
        player.imageName = "luckin317"
        save(context: context)
        return player
    }
    
    func updatePlayerLevel(level: Int, mode: DifficultyMode, id: UUID, context: NSManagedObjectContext) {
        let player = getPlayerById(with: id, context: context) ?? Player()
        player.easyLevel = mode == .easy ? Int64(level) : player.easyLevel
        player.mediumLevel = mode == .medium ? Int64(level) : player.mediumLevel
        save(context: context)
    }
    
    func addBadgeForPlayer(badgeName: String, id: UUID, context: NSManagedObjectContext) {
        let player = getPlayerById(with: id, context: context) ?? Player()
        var badges = player.badges ?? []
        badges.append(badgeName as NSString)
        player.badges = badges
        save(context: context)
    }

    func getPlayerById(with id: UUID?, context: NSManagedObjectContext) -> Player? {
        guard let id = id else { return nil }
        let request = Player.fetchRequest() as NSFetchRequest<Player>
        request.predicate = NSPredicate(
            format: "%K == %@", "id", id as CVarArg
        )
        guard let players = try? context.fetch(request) else { return nil }
        return players.first
    }
    
    // For later used if on time
    func deleteAll() {
          let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Player.fetchRequest()
          let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
          _ = try? container.viewContext.execute(batchDeleteRequest1)
    }
}
