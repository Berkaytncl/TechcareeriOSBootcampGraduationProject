//
//  LoginScreen.swift
//  GraduationProject
//
//  Created by Berkay Tuncel on 6.02.2023.
//

import UIKit
import Lottie

class LoginScreen: UIViewController {

    var loginScreenPresenterObject: ViewToPresenterLoginScreenProtocol?
    
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginScreenRouter.createModule(ref: self)
        
        configureAnimationView()
    }

    @IBAction func loginClicked(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        loginScreenPresenterObject?.login(email: email, password: password)
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text

        loginScreenPresenterObject?.signup(email: email, password: password)
    }
}

extension LoginScreen: PresenterToViewLoginScreenProtocol {
    func dataSendToView(loginSuccess: Bool, error: Error?) {
        if loginSuccess {
            self.performSegue(withIdentifier: Constants.Destination.toHomeScreen, sender: nil)
        } else {
            guard let error = error else {
                self.errorMessage(titleInput: Constants.error, messageInput: Constants.enterValidMailOrPassword)
                return
            }
            self.errorMessage(titleInput: Constants.error, messageInput: error.localizedDescription)
        }
    }
}

extension LoginScreen {
    func configureAnimationView() {
        animationView.animation = .asset("lottieRestaurant")
        animationView.loopMode = .loop
        
        if !animationView.isAnimationPlaying {
            animationView.play()
        }
    }
    
    func errorMessage(titleInput: String, messageInput: String) { 
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: Constants.ok, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
