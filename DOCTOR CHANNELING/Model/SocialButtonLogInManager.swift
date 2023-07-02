
import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

struct SocialButtonManager {
    
    static func logInUsingGoogle(currentVC : UIViewController) {
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
                    currentVC.present(currentVC.setupMainInterfaceNavController(), animated: true)
                }
            }
        }
    }
    
}
