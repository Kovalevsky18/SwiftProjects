
import UIKit
enum Direction{
    case right
    case left
}
class StartViewController: UIViewController {
    
    @IBOutlet weak var textFieldWithName: UITextField!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var leftSide: UIView!
    @IBOutlet weak var rightSide: UIView!
    @IBOutlet weak var road: UIImageView!
    @IBOutlet weak var alert: UILabel!
    @IBOutlet weak var okayAlert: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCar()
        makeRoadLines()
        makeAnimate()
        swipe()
        alertView.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        check()
        AppConfig.makeLabelFont(label: alert, size: 71)
        AppConfig.makeButtonFont(button: okayAlert, size: 54)
    }
    
    func makeCar() {
        AppConfig.car.frame = CGRect(x: self.road.frame.width/4 + CGFloat(AppConfig.carWidth)/2, y: view.frame.maxY - CGFloat(AppConfig.carHeight) - CGFloat(AppConfig.bottomStep), width: CGFloat(AppConfig.carWidth), height: CGFloat(AppConfig.carHeight) )
        AppConfig.car.image = UIImage(named: StorageManager.shared.loadCar() ?? "car_red_1")
        AppConfig.car.contentMode = .scaleAspectFit
        view.addSubview(AppConfig.car)
    }
    
    func makeRoadLines() {
        AppConfig.roadLine.frame = CGRect(x:self.view.frame.maxX/2 - AppConfig.roadLine.frame.width/2, y: self.road.frame.minY - AppConfig.roadLine.frame.height - 100 ,width: 5,height: 85)
        AppConfig.roadLine.backgroundColor = .white
        self.view.addSubview(AppConfig.roadLine)
        UIView.animate(withDuration: StorageManager.shared.loadSpeed() ?? 2.0, animations: {
            AppConfig.roadLine.frame.origin.y += self.view.frame.height + AppConfig.roadLine.frame.height + 100
        }) { (_) in
        }
    }
    
    func makeAnimate() {
        AppConfig.timer = Timer.scheduledTimer(withTimeInterval: StorageManager.shared.loadSpeed() ?? 2.0, repeats: true, block: { (_) in
            self.makeRoadLines()
            self.createBushes(direction: .left)
            self.createBushes(direction: .right)
            self.makeRocks()
        })
        AppConfig.timer.fire()
    }
    
    func makeRocks(){
        let number = Int.random(in: 0 ..< 2)
        var random = [self.leftSide.frame.width , self.road.frame.width/2 + self.leftSide.frame.width]
        AppConfig.rock.frame = CGRect(x: random[number], y : 40 , width:self.road.frame.width/2 , height: self.leftSide.frame.width)
        AppConfig.rock.contentMode = .scaleToFill
        AppConfig.rock.image = UIImage(named: StorageManager.shared.loadTrash() ?? "rock2")
        self.view.addSubview(AppConfig.rock)
        UIImageView.animate(withDuration: StorageManager.shared.loadSpeed() ?? 2.0 , animations: {
            AppConfig.rock.frame.origin.y += self.road.frame.height + AppConfig.rock.frame.height+100
        }) { (_) in
            
        }
        
    }
    
    func check() {
        
        AppConfig.checkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (_) in
            if AppConfig.car.frame.intersects(AppConfig.rock.layer.presentation()!.frame){
                AppConfig.timer.invalidate()
                self.alertView.isHidden = false
            }
        })
    }
    
    func swipe() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
    }
    
    
    func createBushes(direction: Direction) {
        let randDistance = Int.random(in: AppConfig.minBushDistance ... AppConfig.maxBushDistance)
        let bush = UIImageView()
        switch direction {
            
        case .left:
            bush.frame = CGRect(x: self.view.frame.origin.x, y: -CGFloat(randDistance), width: self.leftSide.frame.width, height: self.leftSide.frame.width)
        case .right:
            bush.frame = CGRect(x: self.view.frame.width - self.rightSide.frame.width, y: -CGFloat(randDistance), width: self.rightSide.frame.width, height: self.rightSide.frame.width)
        }
        bush.image = #imageLiteral(resourceName: "tree_small.png")
        self.view.addSubview(bush)
        UIImageView.animate(withDuration: StorageManager.shared.loadSpeed() ?? 2.0, animations: {
            bush.frame.origin.y += self.view.frame.height + bush.frame.height + CGFloat(randDistance)
        }) { (_) in
        }
    }
    
    
    @IBAction func rightSwipeAction(_ sender:UISwipeGestureRecognizer){
        UIView.animate(withDuration: 0.3, animations: {
            AppConfig.car.frame.origin.x += self.road.frame.width/2
        }) { (_) in
            if AppConfig.car.frame.origin.x >= self.rightSide.frame.origin.x{
                AppConfig.timer.invalidate()
                self.alertView.isHidden = false
                
            }
        }
    }
    @IBAction func leftSwipeAction(_ sender:UISwipeGestureRecognizer){
        UIView.animate(withDuration: 0.3, animations: {
            AppConfig.car.frame.origin.x -= self.road.frame.width/2
        }) { (_) in
            if AppConfig.car.frame.origin.x <= self.leftSide.frame.origin.x{
                AppConfig.timer.invalidate()
                self.alertView.isHidden = false
            }
        }
    }
    @IBAction func okButtonLoseAlert(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        var name = textFieldWithName.text
        
        AppConfig.score = 10
        if let name = name{
            StorageManager.shared.addNewRecord(Record(name:name, score: AppConfig.score))
        }
        
        
        
    }
    
}
