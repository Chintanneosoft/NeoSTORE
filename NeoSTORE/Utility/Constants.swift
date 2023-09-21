import Foundation
import UIKit

struct AppFont {
   static var size : CGFloat = 13.0
}

enum Font : String {
    case fontBold = "Gotham-Bold"
    case fontRegular = "Gotham-Medium"
    case fontThin = "Gotham-Book"
}

enum Color{
    
}

enum ScreenText{
    enum Login{
        static let submitButton = "SUBMIT"
        static let loginButton = "LOGIN"
        static let submitbtn = "SUBMIT"
    }
    enum Register{
//        static let
    }
}

enum AlertText{
    enum Title{
        static let success = "Success"
        static let error = "Error"
        static let alert = "Alert"
    }
}
