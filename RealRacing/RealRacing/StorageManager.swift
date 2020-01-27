import UIKit
import Foundation
enum Keys: String {
    case recordsArray = "recordsArray"
}
class StorageManager{
    static let shared = StorageManager()
    init() {}
    var carKey = "car"
    var trashKey = "trashKey"
    var speedKey = "speed"
    let defaults = UserDefaults.standard
    func saveCar(text:String){
        defaults.set(text, forKey: carKey)
        defaults.synchronize()
    }
    func saveRock(text:String){
        defaults.set(text, forKey: trashKey)
        defaults.synchronize()
    }
    
    func loadCar()->String?{
        let text = defaults.string(forKey: carKey)
        return text
    }
    func loadTrash()->String?{
        let text = defaults.string(forKey: trashKey)
        return text
    }
    func saveSpeed(speed:Double){
        defaults.set(speed,forKey:speedKey)
        defaults.synchronize()
    }
    func loadSpeed()->Double?{
        let speed = defaults.double(forKey: speedKey)
        return speed
    }

    func getRecordsArray() -> [Record]? {
           guard let data = self.defaults.value(forKey: Keys.recordsArray.rawValue) as? Data else {
               return nil
           }
           let recordsArray = try? JSONDecoder().decode([Record].self, from: data)
           if var array = recordsArray {
               array.sort {$0.getScore() > $1.getScore()}
               return array
           } else {
               return nil
           }
       }
       
       func saveRecordsArray(recordsArray: [Record]) {
           if let data = try? JSONEncoder().encode(recordsArray) {
               self.defaults.set(data, forKey: Keys.recordsArray.rawValue)
               self.defaults.synchronize()
           }
       }
       
       func addNewRecord(_ record: Record) {
           if var recordsArray = self.getRecordsArray() {
               recordsArray.append(record)
               self.saveRecordsArray(recordsArray: recordsArray)
           } else {
               var recordsArray: [Record] = []
               recordsArray.append(record)
               self.saveRecordsArray(recordsArray: recordsArray)
           }
       }
}

