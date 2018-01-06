//
//  MessageTableViewCell.swift
//  Pulse
//
//  Created by Luke Klinker on 1/5/18.
//  Copyright © 2018 Luke Klinker. All rights reserved.
//

import UIKit
import ActiveLabel

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var message: ActiveLabel!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var timestamp: UILabel!
    
    private let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageContainer.layer.cornerRadius = 8
        messageContainer.layer.masksToBounds = true
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
    }
    
    func bind(conversation: Conversation, message: Message) {
        self.message.text = message.data
        self.timestamp.text = dateFormatter.string(from: Date(milliseconds: message.timestamp))
        
        setupLabel(label: self.message, conversation: conversation)
    }
    
    private func setupLabel(label: ActiveLabel, conversation: Conversation) {
        if (self is ReceivedMessageTableViewCell) {
            label.URLColor = UIColor.white
        } else {
            label.URLColor = UIColor(rgb: conversation.colorAccent)
        }
        
        label.urlMaximumLength = 20
        label.handleURLTap {
            if let url = URL(string: $0.absoluteString) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}