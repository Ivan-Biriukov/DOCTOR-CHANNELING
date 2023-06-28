import Foundation

struct UserProfileDataModel {
    let cardInfo : UserCardInfo?
}

struct UserCardInfo {
    let cardNumber : Int
    let expireDate : String
    let cvc: Int
    let cardHolder : String
}
