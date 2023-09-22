import Foundation
import UIKit

//MARK: - Enums
enum Font : String {
    case fontBold = "Gotham-Bold"
    case fontRegular = "Gotham-Medium"
    case fontThin = "Gotham-Book"
}

enum Color: String{
    case primaryForeground = "Primary Foreground"
    case primaryBackground = "Primary Background"
    case blackBackground = "Black Background"
}

enum UserDefaultsKeys: String{
    case accessToken = "accessToken"
    case userFirstName = "userFirstName"
    case userAddress = "userAddress"
}
//MARK: - ScreenText
enum ScreenText{
    enum Login:String{
        case submitButton = "SUBMIT"
        case loginButton = "LOGIN"
        case userName = "Username"
        case password = "Password"
    }
    enum Register:String{
        case navTitle = "Register"
        case male = "M"
        case female = "F"
        case firstName = "First Name"
        case lastName = "Last Name"
        case email = "Email"
        case password = "Password"
        case confirmPassword = "Confirm Password"
        case phoneNo = "Phone Number"
    }
    enum ResetPassword:String{
        case navTitle = "Reset Password"
        case currentPassword = "Current Password"
        case newPassword = "New Password"
        case confirmPassword = "Confirm Password"
    }
    enum Home:String{
        case navTitle = "NeoSTORE"
        case name = "name"
        case lblPosition = "lblPosition"
    }
    enum Drawer:String{
        case cartCount = "cartCount"
        case option = "option"
    }
    enum ProductList:String{
        case tables = "Tables"
        case chairs = "Chairs"
        case sofas = "Sofas"
        case cupboards = "Cupboards"
    }
    enum ProductDetails:String{
        case description = "DESCRIPTION"
    }
    enum Cart:String{
        case navTitle = "My Cart"
        case cartEmpty = "Cart empty."
    }
    enum AddressList:String{
        case navTitle = "Address List"
    }
    enum AddAddress:String{
        case navTitle = "Add Address"
    }
    enum MyOrders:String{
        case navTitle = "My Orders"
        case orderID = "Order ID : "
        case orderDate = "Ordered Date: "
        case qty = "QTY :"
    }
    enum Profile:String{
        case navTitle = "My Account"
        case done = "Done"
        case chooseOption = "Choose Option"
        case camera = "Camera"
        case gallery = "Gallery"
        case cancel = "Cancel"
        case submit = "SUBMIT"
        case editProfile = "EDIT PROFILE"
    }
    enum Common:String{
        case rupees = "₹"
    }
}

//MARK: - ImageText
enum ImageNames: String{
    case user = "username_icon"
    case password = "password_icon"
    case email = "email_icon"
    case phoneNo = "cell_icon"
    case menu = "menu_icon"
    case cart = "cart.fill"
    case search = "search_icon"
    case starCheck = "star_check"
    case starUncheck = "star_unchek"
    case delete = "delete"
    case plus = "plus"
    case dob = "dob_icon"
}

//MARK: - AlertText
enum AlertText{
    enum Title:String{
        case success = "Success"
        case error = "Error"
        case alert = "Alert"
    }
    enum Message:String{
        case genderAlert = "Select Gender"
        case termsAndConditions = "Agree with terms and conditions"
        case deleteConfirmation = "Do you want to delete the row"
        case selectAddress = "Select Address"
        case emptyFields = "Fill all the Fields"
        case addAddressSuccess = "Your Address is Saved Successfully"
    }
}

//MARK: - APIServiceText
enum APIServiceText:String{
    case email = "email"
    case password = "password"
    case oldPassword = "old_password"
    case confirmPassword = "confirm_password"
    case firstName = "first_name"
    case lastName = "last_name"
    case gender = "gender"
    case phoneNo = "phone_no"
    case productCategoryId = "product_category_id"
    case productId = "product_id"
    case quantity = "quantity"
    case rating = "rating"
    case address = "address"
    case orderId = "order_id"
    case dob = "dob"
    case profilePic = "profile_pic"
}

//MARK: - Cells
enum Cells:String{
    case HomeCollectionViewCell = "HomeCollectionViewCell"
    case ImageSliderCell = "ImageSliderCell"
    case DrawerHeaderTableViewCell = "DrawerHeaderTableViewCell"
    case OptionsCell = "OptionsCell"
    case ProductListCell = "ProductListCell"
    case StarCell = "StarCell"
    case ProductsNameCell = "ProductsNameCell"
    case ProductsDetailCell = "ProductsDetailCell"
    case ProductImageCollectionViewCell = "ProductImageCollectionViewCell"
    case CartCell = "CartCell"
    case TotalCell = "TotalCell"
    case AddressListCell = "AddressListCell"
    case MyOrderCell = "MyOrderCell"
    case OrderDetailsCell = "OrderDetailsCell"
    case StoreLocatorCell = "StoreLocatorCell"
}

//MARK: - ViewControllers
enum ViewControllerString:String{
    case Login = "LoginViewController"
    case ResetPassword = "ResetPasswordViewController"
    case Register = "RegisterViewController"
    case Home = "HomeViewController"
    case HomeContainer = "HomeContainerViewController"
    case Drawer = "DrawerViewController"
    case ProductList = "ProductListViewController"
    case ProductDetails = "ProductDetailsViewController"
    case EnterQuantity = "EnterQuantityViewController"
    case RatingPopUP = "RatingPopUiViewController"
    case Cart = "CartViewController"
    case AddressList = "AddressListViewController"
    case AddAddress = "AddAddressViewController"
    case MyOrder = "MyOrdersViewController"
    case OrderDetails = "OrderDetailsViewController"
    case Profile = "ProfileViewController"
    case StoreLocator = "StoreLocatorViewController"
}

