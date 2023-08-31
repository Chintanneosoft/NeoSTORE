//
//  APIServices.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 23/08/23.
//

import Foundation

// MARK: - Constansts for APIService
let Dev_Root_Point = "http://staging.php-dev.in:8844/trainingapp"
let Prod_Root_Point = ""

let contentValue = "application/x-www-form-urlencoded"
let contentKey = "Content-Type"

enum  NetworkEnvironment : String{
    case dev
    case prod
}

var networkEnvironment: NetworkEnvironment {
    return .dev
}
// BaseURL
var baseURL : String{
    switch networkEnvironment {
    case .dev:
        return Dev_Root_Point
    case .prod:
        return Prod_Root_Point
    }
}

//MARK: - APIService
enum APIServices{
    //All Possible Requests
    case userRegister(param: [String:Any])
    case userLogin(param: [String:Any])
    case fetchProductsList(param: [String:Any])
    case fetchProductsDetails(param: [String:Any])
    case setRatings(param : [String:Any])
    case addToCart(param: [String: Any])
    
    // Setting url path
    var path: String{
        let apiDomain = "/api/"
        var urlPath:String = ""
        switch self{
            
        case .userRegister:
            urlPath = "users/register"
        case .userLogin:
            urlPath = "users/login"
        case .fetchProductsList:
            urlPath = "products/getList"
        case .fetchProductsDetails:
            urlPath = "products/getDetail"
        case .setRatings:
            urlPath = "products/setRating"
        case .addToCart:
            urlPath = "addToCart"
        }
            return baseURL + apiDomain + urlPath
        }
        
        
        // Setting HTTP Method
        var httpMethod: String {
            switch self {
            case .userLogin,.userRegister,.setRatings,.addToCart:
                return "POST"
            default:
                return "GET"
            }
        }
        
        // Param to pass in HTTPBody of URL
        var param: [String:Any]? {
            switch self {
            case .userRegister(param: let param), .userLogin(let param),.fetchProductsList(param: let param),.fetchProductsDetails(param: let param),.setRatings(param: let param),.addToCart(param: let param):
                return param
            default:
                return nil
            }
        }
        
        // Setting Header for Request
        var header: [String:String] {
            var dict:[String:String]
            dict = [contentKey:contentValue,"access_token":UserDefaults.standard.string(forKey:"accessToken") ?? ""]
            return dict
        }
    }
    
