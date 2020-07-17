//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    // No need to call DispathQueue.main.async here because we already pushed the code into main thread in TMDBCliend.swift file through taskForGETRequest function
    @IBAction func loginViaWebsiteTapped() {
        TMDBClient.getRequestToken { (success, error) in
            if success{
                UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
            }
        }
    }
    
    // No need to call DispathQueue.main.async here because we already pushed the code into main thread in TMDBCliend.swift file through taskForGETRequest function
    func handleRequestTokenResponse(success: Bool, error: Error?){
        if success{
            print(TMDBClient.Auth.requestToken)
            TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:Error:))
            }
    }
    
    func handleLoginResponse(success: Bool, Error: Error?){
        print(TMDBClient.Auth.requestToken)
        if success{
            TMDBClient.createSessionId(completion: handleSessionResponse(success:Error:))
        }
    }
    
    // No need to call DispathQueue.main.async here because we already pushed the code into main thread in TMDBCliend.swift file through taskForPOSTRequest function
    func handleSessionResponse(success: Bool, Error: Error?){
        if success{
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
        }
    }
    
}
