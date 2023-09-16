import UIKit

//wrong
class HomeViewModel: NSObject {
    var sliderImages = ["slider_img1","slider_img2","slider_img3","slider_img4"]
    var furnitureData:[[String:Any]] = [["name":"Table","lblPosition":Positions.topRight,"imgName":"table","imgPosition":Positions.bottomLeft], ["name":"Sofas","lblPosition":Positions.bottomLeft,"imgName":"sofa","imgPosition":Positions.topRight],["name":"Chairs","lblPosition":Positions.topLeft,"imgName":"chair","imgPosition":Positions.bottomRight],["name":"Cupboards","lblPosition":Positions.bottomRight,"imgName":"cupboard","imgPosition":Positions.topLeft]]
}
