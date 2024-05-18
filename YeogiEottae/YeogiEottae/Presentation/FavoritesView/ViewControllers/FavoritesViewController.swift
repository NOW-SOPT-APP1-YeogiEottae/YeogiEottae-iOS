//
//  FavoritesViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    
    let rootView: FavoritesView = FavoritesView()
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    
    private func configureViewHierarchy() {
        
    }
    
    private func setConstraints() {
        
    }
    
    
}
