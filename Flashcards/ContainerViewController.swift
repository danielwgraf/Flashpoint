//
//  ContainerViewController.swift
//  SlideOutNavigation
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

class ContainerViewController: UIViewController {
  
    var serverAgent = ServerAgent.sharedInstance
    
    var centerNavigationController: UINavigationController!
    var centerViewController: CenterViewController!
    
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController: SidePanelViewController?
    var rightViewController: SidePanelViewController?
    
    
    // MARK: Side Panel Slideout Distance
    let centerPanelExpandedOffsetLeft: CGFloat = UIScreen.main.bounds.width*0.6
    let centerPanelExpandedOffsetRight: CGFloat = UIScreen.main.bounds.width-150
//    func refresh(completion: () -> Void) {
//        serverAgent = ServerAgent.sharedInstance
//    }
    
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
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(notAlreadyExpanded)
    }
    
    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .rightPanelExpanded)
        
        if notAlreadyExpanded {
            addRightPanelViewController()
        }
        
        animateRightPanel(notAlreadyExpanded)
    }
    
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
    
    func addLeftPanelViewController() {
        if (leftViewController == nil) {
            leftViewController = UIStoryboard.leftViewController()
            
            addChildSidePanelController(leftViewController!)
        }
    }
    
    func addRightPanelViewController() {
        if (rightViewController == nil) {
            rightViewController = UIStoryboard.rightViewController()
            
            addChildSidePanelController(rightViewController!)
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = centerViewController
    
        view.insertSubview(sidePanelController.view, at: 0)
    
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    
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
    
    func animateCenterPanelXPosition(_ targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    
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
