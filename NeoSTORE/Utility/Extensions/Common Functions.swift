import Foundation
import UIKit
import SwiftLoader

//MARK: - UIViewController
extension UIViewController{
    //MARK: - IphoneSe Check
    func isiPhoneSE() -> Bool {
            let screenHeight = UIScreen.main.bounds.height
            return screenHeight <= 667
    }
    
    //MARK: - Loader
    func showLoader() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 60
        config.backgroundColor = .systemGray6
        config.spinnerColor = UIColor(named: "Primary Background") ?? .red
        config.spinnerLineWidth = 2
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
    }
    
    func hideLoader() {
        SwiftLoader.hide()
    }
    
    //MARK: - Alert
    func showSingleButtonAlert(title: String,msg :String, okClosure: (()->Void)?){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            okClosure?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDualButtonAlert(title: String, msg: String, okClosure: (()->Void)?, cancelClosure:(()->Void)? ){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (action) in
            okClosure?()
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            cancelClosure?()
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Navigation Bar
    func setNavBarStyle(fontName:String,fontSize:Int){
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "Primary Background")
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: fontName, size: CGFloat(fontSize))!,
            NSAttributedString.Key.foregroundColor: UIColor.customColor(Color.primaryForeground)
        ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = UIColor.customColor(Color.primaryForeground)
        
        let backButton = UIBarButtonItem()
        backButton.title = "" // Set an empty title
        navigationItem.backBarButtonItem = backButton
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
    }
}

//MARK: - Notification
extension Notification.Name {
    static let updateCart = Notification.Name("updateCart")
    static let updateDrawer = Notification.Name("UpdateDrawerNotification")
}

//wrong
extension NSObject{
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //wrong
    func saveImage(image: UIImage, withName imageName: String) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let fileURL = getDocumentsDirectory().appendingPathComponent(imageName)
            do {
                try imageData.write(to: fileURL)
                print("Image saved successfully at path: \(fileURL.path)")
            } catch {
                print("Error saving image: \(error.localizedDescription)")
            }
        }
    }
    
    func loadProfileImage(imageName: String) -> UIImage? {
        let imgName = imageName + ".jpg"
        let fileURL = getDocumentsDirectory().appendingPathComponent(imgName)
        print(fileURL.path)
        return UIImage(contentsOfFile: fileURL.path)
    }
}

//MARK: - UITextField
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 20, y: 0, width: 15, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 10, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: iconContainerView.leadingAnchor),
            iconView.trailingAnchor.constraint(equalTo: iconContainerView.trailingAnchor,constant: -30),
            iconView.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            iconView.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor)
        ])
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setPlaceholder(_ placeholder: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.customColor(Color.primaryForeground)])
    }
}

//MARK: - UIFont
extension UIFont {
    static func customFont(_ font: Font, size: CGFloat) -> UIFont {
        return UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

//MARK: - UIColor
extension UIColor {
    static func customColor(_ color: Color) -> UIColor{
        return UIColor(named: color.rawValue) ?? UIColor.black
    }
}

