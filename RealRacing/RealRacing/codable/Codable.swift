
import Foundation
import UIKit
class Record: Codable {
    
    private var name: String
    private var score: Int
    
    enum CodingKeys: String, CodingKey {
        case name, score
    }
    
    init (name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.score = try container.decodeIfPresent(Int.self, forKey: .score) ?? 0
            }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.score, forKey: .score)
      
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getScore() -> Int {
        return self.score
    }
    
 
    
}
