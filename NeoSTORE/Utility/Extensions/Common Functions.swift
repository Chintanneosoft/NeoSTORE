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
    
    func showSingleButtonAlert(){
        
    }
    func showDualButtonAlert(title: String, msg: String, okClosure: (()->Void)?, cancelClosure:(()->Void)? ){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
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
            NSAttributedString.Key.foregroundColor: UIColor(named: "Primary Foreground")!
        ]
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        // Optionally, set other navigation bar properties
        navigationController?.navigationBar.tintColor = UIColor(named: "Primary Foreground")
        
    }
}

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
