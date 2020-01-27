import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!
    let imagePicker = UIImagePickerController()
    var avatar = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        
    }
   
    override func  viewWillAppear(_ animated: Bool) {
        startButton.roundCorner()
        startButton.dropShadow(color: .yellow, opacity: 0.5, radius: 10.0)
        settingsButton.roundCorner()
        settingsButton.dropShadow(color: .yellow, opacity: 0.5, radius: 10.0)
        recordsButton.roundCorner()
        recordsButton.dropShadow(color: .yellow, opacity: 0.5, radius: 10.0)
        AppConfig.makeButtonFont(button: startButton, size: 25)
        AppConfig.makeButtonFont(button: settingsButton, size: 25)
        AppConfig.makeButtonFont(button: recordsButton, size: 25)
        
    
    }
    func pickLibrary(){
    self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    func pickWithCamera(){
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = true
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    func alert() {
        let alert = UIAlertController(title: "Avatar", message: "Choose avatar", preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "library" , style: .default, handler: {(alert) in self.pickLibrary()})
        let cameraAction = UIAlertAction(title: "camera" , style: .default, handler: {(alert) in self.pickWithCamera()})
        alert.addAction(libraryAction)
        alert.addAction(cameraAction)
        self.present(alert, animated:true, completion: nil)

    }

    

    @IBAction func startButtonAction(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true )

    }
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true )
    }
    @IBAction func recordsButtonAction(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "RecordsViewController") as? RecordsViewController else {return}
        self.navigationController?.pushViewController(controller, animated: true )

    }
    @IBAction func avatarButtonAction(_ sender: UIButton) {
        alert()
    }
    
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.imageViewOutlet.image = pickedImage
            avatar = pickedImage
            self.imagePicker.dismiss(animated: true)
            
        }
    }
}
