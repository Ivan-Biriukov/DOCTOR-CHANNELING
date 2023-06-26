import UIKit

struct DoctorsCardsManager {
    
    var doctorsArray : [DoctorCardModel] = [
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr. Pretty", description: "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.", raiting: "5.0", isLiked: true),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Pawan", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "4.8", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr.Wanitha", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "3.3", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Udara", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "5.0", isLiked: true)
    ]
    
    var allDoctorsArray : [DoctorCardModel] = [
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr. Pretty", description: "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.", raiting: "5.0", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Pawan", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "4.8", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr.Wanitha", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "3.3", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Udara", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "5.0", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr. Pretty", description: "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.", raiting: "5.0", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Pawan", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "4.8", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr.Wanitha", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "3.3", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Udara", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "5.0", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr. Pretty", description: "Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.", raiting: "5.0", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Pawan", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "4.8", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.fourthDoctorImage)!, name: "Dr.Wanitha", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "3.3", isLiked: false),
        .init(imgae: UIImage(named: K.Doctors.secondDoctorImage)!, name: "Dr.Udara", description: "Jorem ipsum dolor, consectetur adipiscing elit. Nunc v libero et velit interdum, ac  mattis.", raiting: "5.0", isLiked: false)
    ]
    
    mutating func loadAllDoctors() {
        for doctor in allDoctorsArray {
            doctorsArray.append(doctor)
        }
    }
    
    
}
