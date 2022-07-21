import Orion
import AfterRespringC
import UIKit


class SBHomeScreenViewHook: ClassHook<UIViewController> {
    
    static let targetName = "SBHomeScreenViewController"
        
    func viewDidAppear(_ arg0: Any?) {
        orig.viewDidAppear(arg0)
        let myAlert = UIAlertController(title: "Test", message: nil, preferredStyle: .actionSheet)
        let myImage = UIImage(contentsOfFile: "/Library/AfterRespring/test.png")
        let smallImage = resizeImage(image: myImage!, width: UIScreen.main.bounds.width-40)
        let action = UIAlertAction(title: "", style: .default)
        action.setValue(smallImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
        myAlert.addAction(action)
        orig.target.present(myAlert, animated: true)
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

