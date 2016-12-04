//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
  @objc optional func toggleLeftPanel()
  @objc optional func toggleRightPanel()
  @objc optional func collapseSidePanels()
}

class CenterViewController: UIViewController {

  
  var delegate: CenterViewControllerDelegate?
    
  
  // MARK: Button actions
  
  @IBAction func menuTapped(_ sender: AnyObject) {
    delegate?.toggleLeftPanel?()
  }
  
  @IBAction func studyBarTapped(_ sender: AnyObject) {
    delegate?.toggleRightPanel?()
  }
  
}

extension CenterViewController: SidePanelViewControllerDelegate {
    
}
