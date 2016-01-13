//
//  StatusMenuController.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 1/12/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, SettingsWindowDelegate, GitHubConnectorDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var totalPRMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    
    var settingsWindow : SettingsWindow!
    var aboutWindow : AboutWindow!
    var githubConnector : GitHubConnector!
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.template = true // best for dark mode
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        settingsWindow = SettingsWindow()
        aboutWindow = AboutWindow()
        settingsWindow.delegate = self
        githubConnector = GitHubConnector(delegate: self)
        
        updatePendingPullRequest()
        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "updatePendingPullRequest", userInfo: nil, repeats: true)
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
    
    @IBAction func aboutClicked(sender: NSMenuItem) {
        aboutWindow.showWindow(nil)
    }
    
    @IBAction func showPRClicked(sender: AnyObject) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/pulls/assigned")!)
    }
    
    func pendingPullRequestDidUpdate(pendingPullRequestModel: PendingPullRequestModel) {
        totalPRMenuItem.title = pendingPullRequestModel.description;
        
        if (pendingPullRequestModel.totalCount.integerValue > 0) {
            let icon = NSImage(named: "PRPending")
            statusItem.image = icon
        } else {
            let icon = NSImage(named: "PROk")
            statusItem.image = icon
        }
    }
    
    func settingsDidUpdate() {
        updatePendingPullRequest()
    }
}
