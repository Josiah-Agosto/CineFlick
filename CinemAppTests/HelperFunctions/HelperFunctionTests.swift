//
//  HelperFunctionTests.swift
//  CinemAppTests
//
//  Created by Josiah Agosto on 4/13/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import XCTest
@testable import CinemApp

class HelperFunctionTests: XCTestCase {
    private var helperFunctions: SlideMenuHelper!
    private var testViewController: SlideViewController!
    private var testBoolIsOpen: Bool!
    
    override func setUp() {
        helperFunctions = SlideMenuHelper()
        testBoolIsOpen = true
    }
    
    // Switching between true and false Test
    func testShouldExpandSlideMenu() {
        testBoolIsOpen = !testBoolIsOpen
        helperFunctions.shouldExpandSlideMenu(testBoolIsOpen) { (expanded) in
            if expanded {
                XCTAssertTrue(expanded)
            } else {
                XCTAssertFalse(expanded)
            }
        }
    }
    
    // Add Slide View Test
    func testAddingSlideController() {
        XCTAssertNil(testViewController)
        helperFunctions.addSlideMenuToWindow(&testViewController)
        XCTAssertNotNil(testViewController)
    }
    
    // Remove Slide View Test
    func testRemovingSlideController() {
        testViewController = SlideViewController()
        XCTAssertNotNil(testViewController)
        helperFunctions.removeSlideMenuToWindow(&testViewController)
        XCTAssertNil(testViewController)
    }
    
}
