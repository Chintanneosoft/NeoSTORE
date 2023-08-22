//
//  RegisterApiService.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 22/08/23.
//

import UIKit

//MARK:- APIService Protocol
protocol RegisterAPIServiceDelegate: AnyObject{
    //    func didRegisteredUser()
    func didRegisteredUser(userData: UserData)
    func didFailToRegister(error: Error)
}
class RegisterAPIService: NSObject {
    weak var APIServiceDelegate: RegisterAPIServiceDelegate?
    
    func registerUser(fname: String, lname: String, email: String, pass: String, cpass: String, gender: String, phone: String){
        
        let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/register")!
        
        let params = ["first_name": fname, "last_name": lname, "email": email, "password": pass, "confirm_password": cpass,"gender": gender, "phone_no": phone]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Attach the data to the request
        request.httpBody = jsonData
        
        // Create a URLSession
        let session = URLSession.shared
        
        // Create a URLSessionDataTask
        let task = session.dataTask(with: request) { data, response, error in
            print("Inside dataTask completion block")
            if let error = error {
                self.APIServiceDelegate?.didFailToRegister(error: error)
                return
            }
            
            if let data = data {
                do {
                    // Decode the response
                    
                    let userData = try JSONDecoder().decode(User.self, from: data)
                    
                    self.APIServiceDelegate?.didRegisteredUser(userData: userData.data!)
                } catch {
                    self.APIServiceDelegate?.didFailToRegister(error: error)
                }
            }
        }
        print("After dataTask execution")
        // Start the task
        task.resume()
        
    }
}
