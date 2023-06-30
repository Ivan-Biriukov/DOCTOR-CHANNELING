import UIKit

struct ChatWithDoctorModel {
     var isDoctorAvalible : Bool?
     var doctorAvatar : UIImage
    var chatHistory : chatHistoryData?
}

struct chatHistoryData {
    var contactName : String
    var lastMessage : String
    var lastMessageTime : String
    var unreadMessagesValue : Int
}
