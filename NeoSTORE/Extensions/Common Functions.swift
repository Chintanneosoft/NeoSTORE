//
//  File.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 24/08/23.
//

import Foundation
import UIKit
import SwiftLoader
extension UIViewController{
    
    //MARK: - Loader
    func showLoader() {
        let parentView = UIView(frame: UIScreen.main.bounds)
        parentView.isUserInteractionEnabled = false
        
        //        let ai = UIActivityIndicatorView(style: .large)
        //        let ai = ActivityIndicatorView(isVisible: false, type: .arcs(count: 4, lineWidth: 2))
        //        ai.type = .arcs(count: 4, lineWidth: 2)
        //        ai.color = .black
        //        ai.startAnimating()
        //        ai.center = parentView.center
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 60
        config.backgroundColor = .systemGray6
        config.spinnerColor = UIColor(named: "Primary Background") ?? .red
        config.spinnerLineWidth = 2
        SwiftLoader.setConfig(config)
        SwiftLoader.show(animated: true)
        //        parentView.addSubview(ai)
        //        view.addSubview(parentView)
        
        // Assign view
        //        aicView = parentView
    }
    
    func hideLoader() {
        //        viewLoaderScreen?.isHidden = true
        SwiftLoader.hide()
    }
    
    //MARK: - Alert
    func showAlert(title: String,msg :String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Navigation Bar
    func setNavBarStyle(fontName:String,fontSize:Int){
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "Primary Background")
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: fontName, size: CGFloat(fontSize))!,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
        ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        // Optionally, set other navigation bar properties
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary Foreground")
        
    }
}

//extension UINavigationController{
//    open override func viewDidLoad() {
//            super.viewDidLoad()
//
//            // Configure the navigation bar appearance
//            let navigationBarAppearance = UINavigationBarAppearance()
//            navigationBarAppearance.configureWithOpaqueBackground()
//            navigationBarAppearance.backgroundColor = UIColor(named: "Primary Background")
//        navigationBarAppearance.titleTextAttributes = [
//            NSAttributedString.Key.font: UIFont(name: Font.fontBold.rawValue, size: 26)!,
//            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
//        ]
//            navigationBar.standardAppearance = navigationBarAppearance
//            navigationBar.scrollEdgeAppearance = navigationBarAppearance
//
//            // Optionally, set other navigation bar properties
//            navigationBar.tintColor = UIColor(named: "Primary Foreground")
//
//
//        }
//}

extension Notification.Name {
    static let updateCart = Notification.Name("updateCart")
    static let updateDrawer = Notification.Name("UpdateDrawerNotification")
}
//extension Notification.Keys {
//    static let cartCount = "newDataKey"
//}

extension NSObject{
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
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
        let imageName = "profile_picture.jpg"
        let fileURL = getDocumentsDirectory().appendingPathComponent(imageName)
        return UIImage(contentsOfFile: fileURL.path)
    }
}
