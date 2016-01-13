//
//  AboutWindow.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 1/13/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

class AboutWindow: NSWindowController {

    override var windowNibName : String! {
        return "AboutWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activateIgnoringOtherApps(true)
    }
    
}
