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
    
    func addPlayer(name: String, pass: String, context: NSManagedObjectContext) {
        let player = Player(context: context)
        player.id = UUID()
        player.name = name
        player.password = pass
        player.imageName = "luckin317"
        player.levelStatus = []
        player.badges = []
        save(context: context)
    }
    
    func fetchPlayerByName(name:String, context: NSManagedObjectContext) -> Player{
        let fetchRequest: NSFetchRequest<Player>
        fetchRequest = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name LIKE %@", name)
        do {
            let player = try context.fetch(fetchRequest).first!
            return player
        } catch {
            print("error")
            return Player()
        }
    }
}
