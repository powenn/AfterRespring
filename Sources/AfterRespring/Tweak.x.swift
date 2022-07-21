import Orion
import AfterRespringC
import UIKit

struct Main: HookGroup {}

class SBHomeScreenViewHook: ClassHook<UIViewController> {
    typealias Group = Main
    static let targetName = "SBHomeScreenViewController"
    
    func viewDidAppear(_ arg0: Any?) {
        orig.viewDidAppear(arg0)
        let myAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let myImage = UIImage(contentsOfFile: "/var/mobile/Library/Preferences/com.powen.afterrespring/selectedImage-IMG") {
            let smallImage = resizeImage(image: myImage, width: UIScreen.main.bounds.width-40)
            let action = UIAlertAction(title: "", style: .default)
            action.setValue(smallImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
            myAlert.addAction(action)
            orig.target.present(myAlert, animated: true)
        }
    }
    
}

func resizeImage(image: UIImage, width: CGFloat) -> UIImage {
    let size = CGSize(width: width, height:
                        image.size.height * width / image.size.width)
    let renderer = UIGraphicsImageRenderer(size: size)
    let newImage = renderer.image { (context) in
        image.draw(in: renderer.format.bounds)
    }
    return newImage
}

class Chocola: Tweak {
    required init() {
        if Preferences.shared.enabled.boolValue && FileManager.default.fileExists(atPath: "/var/mobile/Library/Preferences/com.powen.afterrespring/selectedImage-IMG") {
            Main().activate()
            
        }
    }
}
