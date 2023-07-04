
import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore

struct SocialButtonManager {
    
    static func logInUsingGoogle(currentVC : UIViewController, db: Firestore) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: currentVC) {  result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                if let e = error {
                    let errorAlert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    let errorAlertAction = UIAlertAction(title: "try agian", style: .cancel)
                    errorAlert.addAction(errorAlertAction)
                    currentVC.present(errorAlert, animated: true)
                } else {
                    var avatarURL : URL?
                    guard let uid = user.userID else {return}
                    guard let userName = user.profile?.name else {return}
                    guard let userEmail = user.profile?.email else {return}
                    if ((user.profile?.hasImage) != nil) {
                        avatarURL = user.profile!.imageURL(withDimension: 100)
                    }
                    
                    db.collection("users: \(Auth.auth().currentUser?.uid ?? uid)").getDocuments { (querySnapshot, err) in
                        if let snapshotDocuments = querySnapshot?.documents {
                            if snapshotDocuments.count == 0 {
                                db.collection("users: \(Auth.auth().currentUser?.uid ?? uid)").addDocument(data: [
                                    "userID" : uid,
                                    "userName" : userName,
                                    "userEmail" : userEmail,
                                    "userPassword" : "unset",
                                    "userPhoneNumber" : "unset",
                                    "userAvatarURL" : avatarURL?.absoluteString ?? ""
                                ])
                            }
                        }
                    }
                    currentVC.present(currentVC.setupMainInterfaceNavController(), animated: true)
                }
            }
        }
    }
    
}
