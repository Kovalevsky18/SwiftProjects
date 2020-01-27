
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var chooseCarLabelOutlet: UILabel!
    @IBOutlet weak var chooseTrashLabelOutlet: UILabel!
    @IBOutlet weak var blueCarOutlet: UIImageView!
    @IBOutlet weak var orangeCarOutlet: UIImageView!
    @IBOutlet weak var rockOutlet: UIImageView!
    @IBOutlet weak var trashOutlet: UIImageView!
    @IBOutlet weak var speedLabelOutlet: UILabel!
    
    @IBOutlet weak var frameTwoX: UIView!
    @IBOutlet weak var frameOneX: UIView!
    @IBOutlet weak var frameTrash: UIView!
    @IBOutlet weak var frameRock: UIView!
    @IBOutlet weak var frameOrangeCar: UIView!
    @IBOutlet weak var frameBlueCar: UIView!
    @IBOutlet weak var twoXSpeed: UIButton!
    @IBOutlet weak var oneXSpeed: UIButton!
    @IBOutlet weak var textField: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
       
        frameOrangeCar.isHidden = true
        frameTrash.isHidden = true
        frameOneX.isHidden = true
        
        let orangeCarDetector = UITapGestureRecognizer(target: self, action:#selector(orangeCar(_:)))
        orangeCarDetector.numberOfTapsRequired = 1
        self.orangeCarOutlet.addGestureRecognizer(orangeCarDetector)
        
        let blueCarDetector = UITapGestureRecognizer(target: self, action:#selector(blueCar(_:)))
        blueCarDetector.numberOfTapsRequired = 1
        self.blueCarOutlet.addGestureRecognizer(blueCarDetector)
        
        let rockDetector = UITapGestureRecognizer(target: self, action:#selector(rock(_:)))
        rockDetector.numberOfTapsRequired = 1
        self.rockOutlet.addGestureRecognizer(rockDetector)
        
        let trashDetector = UITapGestureRecognizer(target: self, action:#selector(trash(_:)))
        blueCarDetector.numberOfTapsRequired = 1
        self.trashOutlet.addGestureRecognizer(trashDetector)
        
        let swipeBack = UISwipeGestureRecognizer(target: self, action: #selector(backSwipe(_:)))
        swipeBack.direction = .right
        self.view.addGestureRecognizer(swipeBack)
        
        AppConfig.makeLabelFont(label: chooseCarLabelOutlet, size: 35)
        AppConfig.makeLabelFont(label: chooseTrashLabelOutlet, size: 35)
        AppConfig.makeLabelFont(label: speedLabelOutlet, size: 35)
        AppConfig.makeButtonFont(button: oneXSpeed, size: 35)
        AppConfig.makeButtonFont(button: twoXSpeed, size: 35)
        
    }
    
    @IBAction func orangeCar(_ sender: UITapGestureRecognizer){
        let orangeCarName = "car_red_1"
        StorageManager.shared.saveCar(text: orangeCarName)
        frameOrangeCar.isHidden = false
        frameBlueCar.isHidden = true
    }
    
    @IBAction func blueCar(_ sender: UITapGestureRecognizer){
        let blueCarName = "car_blue_1"
        StorageManager.shared.saveCar(text: blueCarName)
        frameOrangeCar.isHidden = true
        frameBlueCar.isHidden = false

    }
    
    @IBAction func rock(_ sender: UITapGestureRecognizer){
        let rockName = "rock2"
        StorageManager.shared.saveRock(text: rockName)
        frameRock.isHidden = false
        frameTrash.isHidden = true
    }
    
    @IBAction func trash(_ sender: UITapGestureRecognizer){
        let trashName  = "trash"
        StorageManager.shared.saveRock(text: trashName)
        frameTrash.isHidden = false
        frameRock.isHidden = true
    }
    
    @IBAction func backSwipe(_ sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func twoXSpeedAction(_ sender: UIButton) {
        let speed = 1.0
        StorageManager.shared.saveSpeed(speed: speed)
        frameTwoX.isHidden = false
        frameOneX.isHidden = true
    }
    
    @IBAction func oneXSpeedAction(_ sender: UIButton) {
        let speed = 2.0
        StorageManager.shared.saveSpeed(speed: speed)
        frameOneX.isHidden = false
        frameTwoX.isHidden = true
    }
    
    
    
    
}
