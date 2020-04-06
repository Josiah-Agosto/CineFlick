//
//  HomeTests.swift
//  HomeTests
//
//  Created by Josiah Agosto on 3/23/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import XCTest
import UIKit
@testable import CinemApp

class HomeTests: XCTestCase {
    private var homeController: HomeScreenController!
    private var navigationController: UINavigationController!
    private var mockViewController: UIViewController!
    private var optionalViewController: UIViewController?

    override func setUp() {
        homeController = HomeScreenController()
        navigationController = UINavigationController()
        mockViewController = UIViewController()
    }

    
    func testAddingViewController() {
        XCTAssertEqual(navigationController.children, [])
        homeController.addChildViewController(from: mockViewController, to: navigationController)
        XCTAssertEqual(navigationController.children, [mockViewController])
    }
    
    
    func testRemovingViewController() {
        XCTAssertEqual(mockViewController.parent, optionalViewController)
        homeController.removeSlideController(from: mockViewController)
        XCTAssertEqual(mockViewController.parent, nil)
    }

}
