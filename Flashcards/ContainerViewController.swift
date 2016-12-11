//
//  ContainerViewController.swift
//  SlideOutNavigation
//  
//  Thank you James Frost and your tutorial on how to do this :)
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
    case bothCollapsed
    case leftPanelExpanded
    case rightPanelExpanded
}
/// Contains Center and sidebars
class ContainerViewController: UIViewController {
    /// Shared Instance
    var serverAgent = ServerAgent.sharedInstance
    
    // Center section
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    
    ///Checks the state of sidebars
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    // Left and right bars
    var leftViewController: SidePanelViewController?
    var rightViewController: SidePanelViewController?
    
    
    // MARK: Side Panel Slideout Distance
    let centerPanelExpandedOffsetLeft: CGFloat = UIScreen.main.bounds.width*0.6
    let centerPanelExpandedOffsetRight: CGFloat = UIScreen.main.bounds.width-150

    // Loading thing
    override func viewDidLoad() {
        super.viewDidLoad()
        centerViewController = UIStoryboard.centerViewController()
        centerViewController.delegate = self
        
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        centerNavigationController = UINavigationController(rootViewController: centerViewController)
        view.addSubview(centerNavigationController.view)
        addChildViewController(centerNavigationController)
        
        centerNavigationController.didMove(toParentViewController: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePanGesture(_:)))
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
    }
  
}

// MARK: CenterViewController delegate

extension ContainerViewController: CenterViewControllerDelegate {
    ///Open or close the left side
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(notAlreadyExpanded)
    }
    
    ///Open or close the right side
    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .rightPanelExpanded)
        
        if notAlreadyExpanded {
            addRightPanelViewController()
        }
        
        animateRightPanel(notAlreadyExpanded)
    }
    
    /// Close both sides
    func collapseSidePanels() {
        switch (currentState) {
        case .rightPanelExpanded:
            toggleRightPanel()
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    /// Adds the left bar from Storyboard
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            
            addChildSidePanelController(leftViewController!)
        }
    }
    
    /// Adds the right bar from Storyboard
    func addRightPanelViewController() {
        if (rightViewController == nil) {
            rightViewController = UIStoryboard.rightViewController()
            
            addChildSidePanelController(rightViewController!)
        }
    }
    
    /// Sets up the child/parent relationship
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = centerViewController
    
        view.insertSubview(sidePanelController.view, at: 0)
    
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    /// Just animate the left panel
    func animateLeftPanel(_ shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .leftPanelExpanded
            
            animateCenterPanelXPosition((centerNavigationController.view.frame).width - centerPanelExpandedOffsetLeft)
        } else {
            animateCenterPanelXPosition(0) { finished in
                self.currentState = .bothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    /// Just animate the right panel
    func animateRightPanel(_ shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .rightPanelExpanded
            
            animateCenterPanelXPosition(-(centerNavigationController.view.frame).width + centerPanelExpandedOffsetRight)
        } else {
            animateCenterPanelXPosition(0) { _ in
                self.currentState = .bothCollapsed
                
                self.rightViewController!.view.removeFromSuperview()
                self.rightViewController = nil;
            }
        }
    }
    
    ///Move the middle part when moving others
    func animateCenterPanelXPosition(_ targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    ///Adds shadows for separation of views
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    // MARK: Gesture recognizer
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        if (gestureIsDraggingFromLeftToRight || (recognizer.view!.center.x != view.center.x)) {
        
            switch(recognizer.state) {
            case .began:
                if (currentState == .bothCollapsed) {
                    if (gestureIsDraggingFromLeftToRight) {
                        addLeftPanelViewController()
                    }
                
                    showShadowForCenterViewController(true)
                }
            case .changed:
                recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
            case .ended:
                if (leftViewController != nil) {
                    // animate the side panel open or closed based on whether the view has moved more or less than halfway
                    let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                    animateLeftPanel(hasMovedGreaterThanHalfway)
                }
              else if (rightViewController != nil) {
                  let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
                  animateRightPanel(hasMovedGreaterThanHalfway)
              }
            default:
                break
            }
        }

    }
    
}

private extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
  class func leftViewController() -> SidePanelViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "LeftViewController") as? SidePanelViewController
  }
  
  class func rightViewController() -> SidePanelViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "RightViewController") as? SidePanelViewController
  }
  
  class func centerViewController() -> CenterViewController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "CenterViewController") as? CenterViewController
  }
  
}
