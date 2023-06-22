
import UIKit

struct SegmentedControllManager {
    
    var itemsArray : [UIImageView] = []
    
    let itemImage : UIImageView = {
        let im = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        im.image = UIImage(systemName: "circle.fill")
        im.tintColor = .textUnavalibleGray
        im.contentMode = .scaleToFill
        return im
    }()
    
    func setupCountOfItems (count: Int) {
        for _ in count {
            itemsArray.append(itemImage)
        }
    }
}
