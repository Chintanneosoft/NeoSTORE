import UIKit

//MARK: - DrawerViewModelDelegate Protocol
protocol DrawerViewModelDelegate:NSObject{
    func setDrawer()
    func failureDrawer(msg: String)
}

//MARK: - DrawerViewModel
class DrawerViewModel:NSObject {
    
    //MARK: - ProductListViewModelDelegate Object Declare
    weak var drawerViewModelDelegate: DrawerViewModelDelegate?
    
    var drawerOptions = ["option0":["My Cart","shoppingcart_icon"],"option1":["Tables","table"],"option2":["Sofas","sofa"],"option3":["Chairs","chair"],"option4":["Cupboards","cupboard"],"option5":["My Account","username_icon"],"option6":["Store Locator","storelocator_icon"],"option7":["My Orders","myorders_icon"],"option8":["Logout","logout_icon"]]
    
    //APIService Object
    private let drawerAPIService = DrawerAPIService()
    
    var userData : FetchUser?
    
    func callFetchUser(){
        drawerAPIService.fetchUser{
            (response) in
            switch response{
            case .success(let value):
                print(value)
                if (value.0 != nil){
                    self.userData = value.0
                    self.drawerViewModelDelegate?.setDrawer()
                }
                else{
                    self.drawerViewModelDelegate?.failureDrawer(msg: value.1!.user_msg!)
                }
            case .failure(let error):
                print(error)
                self.drawerViewModelDelegate?.failureDrawer(msg: error.localizedDescription)
            }
        }
    }
}


