//
//  WelcomeViewController.swift
//  ChatFirebase
//
//  Created by Mitya Kim on 6/18/22.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imageLabel: CLTypingLabel!
    @IBOutlet weak var chatLabel: CLTypingLabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animationLabel()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Helper Methods
    func animationLabel() {
        imageLabel.text = "Write a message!"
        chatLabel.text = Strings.appName
        imageLabel.onTypingAnimationFinished = {
            self.imageLabel.text = "💬"
        }
    }
    
    func setupViews() {
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
    }
}
