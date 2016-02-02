//
//  CopyPasteTextField.swift
//  PullRequestNotifierBar
//
//  Created by Nicolas Battelli on 2/2/16.
//  Copyright © 2016 Trend Team. All rights reserved.
//

import Cocoa

class CopyPasteTextField: NSTextField {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    private let commandKey = NSEventModifierFlags.CommandKeyMask.rawValue
    private let commandShiftKey = NSEventModifierFlags.CommandKeyMask.rawValue | NSEventModifierFlags.ShiftKeyMask.rawValue
    override func performKeyEquivalent(event: NSEvent) -> Bool {
        if event.type == NSEventType.KeyDown {
            if (event.modifierFlags.rawValue & NSEventModifierFlags.DeviceIndependentModifierFlagsMask.rawValue) == commandKey {
                switch event.charactersIgnoringModifiers! {
                case "x":
                    if NSApp.sendAction(Selector("cut:"), to:nil, from:self) { return true }
                case "c":
                    if NSApp.sendAction(Selector("copy:"), to:nil, from:self) { return true }
                case "v":
                    if NSApp.sendAction(Selector("paste:"), to:nil, from:self) { return true }
                case "z":
                    if NSApp.sendAction(Selector("undo:"), to:nil, from:self) { return true }
                case "a":
                    if NSApp.sendAction(Selector("selectAll:"), to:nil, from:self) { return true }
                default:
                    break
                }
            }
            else if (event.modifierFlags.rawValue & NSEventModifierFlags.DeviceIndependentModifierFlagsMask.rawValue) == commandShiftKey {
                if event.charactersIgnoringModifiers == "Z" {
                    if NSApp.sendAction(Selector("redo:"), to:nil, from:self) { return true }
                }
            }
        }
        return super.performKeyEquivalent(event)
    }
}
