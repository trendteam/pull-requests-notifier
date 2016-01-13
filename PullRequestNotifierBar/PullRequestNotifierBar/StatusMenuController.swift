//
//  StatusMenuController.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 1/12/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, SettingsWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    
    var settingsWindow : SettingsWindow!
    var githubConnector : GitHubConnector!
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.template = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        settingsWindow = SettingsWindow();
        settingsWindow.delegate = self;
        githubConnector = GitHubConnector();
        
        updatePendingPullRequest()
    }
    
    func updatePendingPullRequest() {
        githubConnector.fetchPendingPullRequest(settingsWindow.retrieveUserName(), token: settingsWindow.retrieveToken())
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBAction func settingsClicked(sender: NSMenuItem) {
        settingsWindow.showWindow(nil)
    }
    
    func settingsDidUpdate() {
        // Actualizar pr pendientes
    }
}
