//
//  YeogiAlertViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/19/24.
//

import UIKit
import SnapKit


final class YeogiAlertViewController: UIViewController {
    
    private let alertView = YeogiAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTarget()
        setHierArchy()
        setConstraints()
    }
    
    private func setHierArchy() {
        self.view.addSubview(alertView)
    }
    
    private func setConstraints() {
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(337)
            $0.height.equalTo(133)
        }
    }
    
    private func configureTarget() {
        alertView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: false)
    }
}
