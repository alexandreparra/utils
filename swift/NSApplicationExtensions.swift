extension NSApplication {
    static func show() {
        NSApp.setActivationPolicy(.regular)
        
        if #available(macOS 14, *) {
            NSApp.activate()
        } else {
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    static func hide() {
        NSApp.hide(self)
        NSApp.setActivationPolicy(.accessory)
    }
    
    // Can't be used on macOS 14 and above, the new way is to use a SettingsLink inside the Settings SwiftUI group or
    // create a NSWindow by hand like: https://github.com/linearmouse/linearmouse/blob/0beed71bd872a48655f03c27bfa724d5c6b20829/LinearMouse/UI/SettingsWindow.swift
    static func showSettings() {
        if #available(macOS 13, *) {
            NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
        } else {
            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        }
    }
}

