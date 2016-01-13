//
//  SettingsWindow.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 1/12/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

protocol SettingsWindowDelegate {
    func settingsDidUpdate()
}

class SettingsWindow: NSWindowController, NSWindowDelegate {

    let USER_DEFAULT_USER_NAME = "userName"
    let USER_DEFAULT_TOKEN = "token"
    
    var delegate : SettingsWindowDelegate?
    
    @IBOutlet weak var userNameTextField: NSTextField!
    @IBOutlet weak var tokenTextField: NSTextField!

    override var windowNibName : String! {
        return "SettingsWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activateIgnoringOtherApps(true)
        
        userNameTextField.stringValue = self.retrieveUserName()
        tokenTextField.stringValue = self.retrieveToken()
    }
    
    func windowWillClose(notification: NSNotification) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(userNameTextField.stringValue, forKey: USER_DEFAULT_USER_NAME)
        defaults.setValue(tokenTextField.stringValue, forKey: USER_DEFAULT_TOKEN)
        
        delegate?.settingsDidUpdate()
    }
    
    func retrieveUserName () -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey(USER_DEFAULT_USER_NAME) ?? "";
    }
    
    func retrieveToken () -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.stringForKey(USER_DEFAULT_TOKEN) ?? "";
    }
    
}
