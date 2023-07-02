import Foundation

struct UserProfileDataModel {
    let userName : String?
    let userEmail: String
    let userPassword: String
    let userPhoneNumber: String?
    let userAvatar : String?
    let cardInfo : UserCardInfo?
}

struct UserCardInfo {
    let cardNumber : Int
    let expireDate : String
    let cvc: Int
    let cardHolder : String
}
