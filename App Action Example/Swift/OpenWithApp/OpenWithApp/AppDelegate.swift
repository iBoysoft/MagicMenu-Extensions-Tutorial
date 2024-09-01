//
//  AppDelegate.swift
//  OpenWithApp
//
//  Created by Jovi on 9/1/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        handleLaunchParams()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate {
    private func handleLaunchParams() {
        let args = ProcessInfo.processInfo.arguments
        if args.count > 4 {
            if args[1] == "-appid" {
                let appid = args[2]
                
                if args[3] == "-urls" {
                    let urls = args[4...].compactMap {
                        if $0.hasPrefix("/") {
                            return URL.init(fileURLWithPath: $0)
                        } else {
                            return nil
                        }
                    }
                    
                    openWithApp(appId: appid, urls: urls)
                }
            } else {
                exit(-2)
            }
        } else {
            exit(-1)
        }
    }
    
    private func openWithApp(appId: String, urls:[URL]) {
        if let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: appId) {
            if #available(macOS 10.15, *) {
                let configure = NSWorkspace.OpenConfiguration()
                configure.activates = true
                NSWorkspace.shared.open(urls, withApplicationAt: appURL, configuration: configure, completionHandler: {
                    _,_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        NSApp.terminate(nil)
                    })
                })
            } else {
                _ = try? NSWorkspace.shared.open(urls, withApplicationAt: appURL, options: NSWorkspace.LaunchOptions.default, configuration: [:])
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    NSApp.terminate(nil)
                })
            }
        } else {
            let alert = NSAlert.init()
            alert.messageText = NSLocalizedString("No corresponding app found", comment: "")
            alert.addButton(withTitle: NSLocalizedString("Ok", comment: ""))
            if alert.runModal() == .alertFirstButtonReturn {
                exit(-3)
            }
        }
    }
}

