//
//  APIServices.swift
//  NeoSTORE
//
//  Created by Neosoft1 on 23/08/23.
//

import Foundation

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

var baseURL : String{
    switch networkEnvironment {
    case .dev:
        return Dev_Root_Point
    case .prod:
        return Prod_Root_Point
    }
}

enum APIServices{
    
    case userRegister(param: [String:Any])
    case userLogin(param: [String:Any])
    
    var path: String{
        let apiDomain = "/api/"
        var urlPath:String = ""
        switch self{
            
        case .userRegister:
        urlPath = apiDomain + "users/register"
        case .userLogin:
        urlPath = apiDomain + "users/login"
            
        }
        return baseURL + urlPath
    }
    
    var httpMethod: String {
        switch self {
//        case :
//            return "GET"
        default:
            return "POST"
        }
    }
    
    var param: [String:Any]? {
        switch self {
        case .userRegister(param: let param), .userLogin(let param):
            return param
        default:
            return nil
        }
    }
    
    var header: [String:String] {
        var dict:[String:String]
        dict = [contentKey:contentValue]
        return dict
    }
}

