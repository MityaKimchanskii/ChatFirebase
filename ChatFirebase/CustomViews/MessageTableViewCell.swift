//
//  MessageTableViewCell.swift
//  ChatFirebase
//
//  Created by Mitya Kim on 6/24/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: - Helper Methods
    func setupViews() {
        bodyLabel.text = ""
        messageView.layer.cornerRadius = messageView.frame.size.height / 5
    }
    
}
