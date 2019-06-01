//  MMStatusBarManager.swift

import UIKit

public class MMStatusBarManager: NSObject {
    public static let shared = MMStatusBarManager()
    
    public var prefersStatusBarHidden: Bool? {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public var preferredStatusBarStyle: UIStatusBarStyle? {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public func setNeedsStatusBarAppearanceUpdate() {
        TopestController()?.setNeedsStatusBarAppearanceUpdate()
    }
    
    public func clear() {
        if let _ = prefersStatusBarHidden {
            prefersStatusBarHidden = nil
        }
        
        if let _ = preferredStatusBarStyle {
            preferredStatusBarStyle = nil
        }
    }
}
