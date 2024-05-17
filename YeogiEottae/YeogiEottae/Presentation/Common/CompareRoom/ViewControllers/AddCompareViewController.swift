//
//  AddCompareViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit
import SnapKit


final class AddCompareViewController: UIViewController {
    
    private var isSelected = false
    
    private let rootView = AddCompareRootView()
    private let dataModel = RoomData.dummyData()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
