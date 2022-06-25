//
//  ChatViewController.swift
//  ChatFirebase
//
//  Created by Mitya Kim on 6/18/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SystemConfiguration
import IQKeyboardManager


class ChatViewController: UIViewController {

    // MARK: - Properties
    var messages: [Message] = []
    
    let dataBase = Firestore.firestore()
    
    // MARK: - Outlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
    }
    
    // MARK: - Actions
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text,
           let messageSender = Auth.auth().currentUser?.email {
            dataBase.collection(Strings.FStore.collectionName).addDocument(data: [
                Strings.FStore.senderField: messageSender,
                Strings.FStore.bodyField: messageBody,
                Strings.FStore.dataField: Date().timeIntervalSince1970
            ]) { error in
                if let error = error {
                    print("There was an error: \(error)")
                } else {
                    print("successfully saved in db!")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        do {
            try  Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // MARK: - Helper Methods
    func setupViews() {
        navigationItem.hidesBackButton = true
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        chatTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        sendButton.layer.cornerRadius = sendButton.frame.height / 2
        loadMessages()
    }
    
    func loadMessages() {
        dataBase.collection(Strings.FStore.collectionName)
            .order(by: Strings.FStore.dataField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            } else {
                if let snapshopDocuments = querySnapshot?.documents {
                    for doc in snapshopDocuments {
                        let data = doc.data()
                        if let sender = data[Strings.FStore.senderField] as? String,
                           let messageBody = data[Strings.FStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.chatTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Extensions
extension ChatViewController: UITableViewDelegate {}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        cell.bodyLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageView.backgroundColor = .systemTeal
        } else {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageView.backgroundColor = .lightGray
        }
        return cell
    }
}
