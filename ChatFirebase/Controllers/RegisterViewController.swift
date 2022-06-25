//
//  RegisterViewController.swift
//  ChatFirebase
//
//  Created by Mitya Kim on 6/18/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Actions
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .actionSheet)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                self.passwordTextField.text = ""
            } else {
                self.performSegue(withIdentifier: Strings.registerSegue, sender: self)
            }
        }
    }
    
    // MARK: - Helper Methods
    func setupViews() {
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
    }
}
