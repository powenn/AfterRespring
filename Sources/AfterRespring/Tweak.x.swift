import Orion
import AfterRespringC
import UIKit

struct Main: HookGroup {}

class SBHomeScreenViewHook: ClassHook<UIViewController> {
    typealias Group = Main
    static let targetName = "SBHomeScreenViewController"
    
    func viewDidAppear(_ arg0: Any?) {
        orig.viewDidAppear(arg0)
        
        if let myImage = UIImage(contentsOfFile: "/var/mobile/Library/Preferences/com.powen.afterrespring/selectedImage-IMG") {
            var myTitle:String? = nil
            Preferences.shared.customTitle as! String != "" ? myTitle = Preferences.shared.customTitle as? String : nil
            
            let myAlert = UIAlertController(title: myTitle, message: nil, preferredStyle: .actionSheet)
            let smallImage = resizeImage(image: myImage, width: UIScreen.main.bounds.width-40)
            let action = UIAlertAction(title: "", style: .default)
            action.setValue(smallImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
            myAlert.addAction(action)
            target.present(myAlert, animated: true)
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

class AfterRespring: Tweak {
    required init() {
        if Preferences.shared.enabled.boolValue && FileManager.default.fileExists(atPath: "/var/mobile/Library/Preferences/com.powen.afterrespring/selectedImage-IMG") {
            Main().activate()
            
        }
    }
}
