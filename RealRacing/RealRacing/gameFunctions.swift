import Foundation
import UIKit

func makeCar() {
    car.frame = CGRect(x: road.frame.width/4 + CGFloat(carWidth)/2, y: view.frame.maxY - CGFloat(carHeight) - CGFloat(bottomStep), width: CGFloat(carWidth), height: CGFloat(carHeight) )
    car.image = #imageLiteral(resourceName: "car_blue_1")
    car.contentMode = .scaleAspectFit
    view.addSubview(car)
}

func makeRoadLines() {
    roadLine.frame = CGRect(x:self.view.frame.maxX/2 - roadLine.frame.width/2, y: self.road.frame.minY - roadLine.frame.height - 100 ,width: 5,height: 85)
    roadLine.backgroundColor = .white
    self.view.addSubview(roadLine)
    UIView.animate(withDuration: roadLineAnimate, animations: {
        roadLine.frame.origin.y += self.view.frame.height + roadLine.frame.height + 100
    }) { (_) in
                }
}

func makeAnimate() {
    timer = Timer.scheduledTimer(withTimeInterval: timerAnimate, repeats: true, block: { (_) in
        self.makeRoadLines()
        self.createBushes(direction: .left)
        self.createBushes(direction: .right)
        self.makeRocks()
    })
    timer.fire()
}

func makeRocks(){
    let number = Int.random(in: 0 ..< 2)
    var random = [self.leftSide.frame.width , self.road.frame.width/2 + self.leftSide.frame.width]
    rock.frame = CGRect(x: random[number], y : 40 , width:self.road.frame.width/2 , height: self.leftSide.frame.width)
        rock.image = #imageLiteral(resourceName: "rock2.png")
        self.view.addSubview(rock)
    UIImageView.animate(withDuration: bushAnimate, animations: {
        rock.frame.origin.y += self.road.frame.height + rock.frame.height+100
   }) { (_) in

   }
    
}

func check() {

    checkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (_) in
        if car.frame.intersects(rock.layer.presentation()!.frame){
            timer.invalidate()
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
        let randDistance = Int.random(in: minBushDistance ... maxBushDistance)
        let bush = UIImageView()
        switch direction {
            
        case .left:
            bush.frame = CGRect(x: self.view.frame.origin.x, y: -CGFloat(randDistance), width: self.leftSide.frame.width, height: self.leftSide.frame.width)
        case .right:
            bush.frame = CGRect(x: self.view.frame.width - self.rightSide.frame.width, y: -CGFloat(randDistance), width: self.rightSide.frame.width, height: self.rightSide.frame.width)
        }
        bush.image = #imageLiteral(resourceName: "tree_small.png")
        self.view.addSubview(bush)
        UIImageView.animate(withDuration: bushAnimate, animations: {
            bush.frame.origin.y += self.view.frame.height + bush.frame.height + CGFloat(randDistance)
        }) { (_) in
                        }
    }


@IBAction func rightSwipeAction(_ sender:UISwipeGestureRecognizer){
    UIView.animate(withDuration: 0.3, animations: {
        car.frame.origin.x += self.road.frame.width/2
    }) { (_) in
        if car.frame.origin.x >= self.rightSide.frame.origin.x{
            timer.invalidate()
            self.alertView.isHidden = false
            
        }
    }
}
@IBAction func leftSwipeAction(_ sender:UISwipeGestureRecognizer){
    UIView.animate(withDuration: 0.3, animations: {
        car.frame.origin.x -= self.road.frame.width/2
       }) { (_) in
           if car.frame.origin.x <= self.leftSide.frame.origin.x{
            timer.invalidate()
            self.alertView.isHidden = false
           }
       }
}
@IBAction func okButtonLoseAlert(_ sender: UIButton) {
    self.navigationController?.popToRootViewController(animated: true)

}
