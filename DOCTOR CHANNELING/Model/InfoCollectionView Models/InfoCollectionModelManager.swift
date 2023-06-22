import UIKit

struct InfoCollectionModelManager {
    
    var dataArray : [InfoCollectionDataModel] = [
        .init(mainTitleText: "Medical Center", descriptionText: "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.", contentImage: UIImage(named: K.Doctors.thirdDoctorImage)!),
        .init(mainTitleText: "Famous", descriptionText: "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.", contentImage: UIImage(named: K.Doctors.secondDoctorImage)!),
        .init(mainTitleText: "Testing", descriptionText: "This is an example of content Text inside this collectionView cell&", contentImage: UIImage(named: K.Doctors.fourthDoctorImage)!)
    ]
    
    
    
}
