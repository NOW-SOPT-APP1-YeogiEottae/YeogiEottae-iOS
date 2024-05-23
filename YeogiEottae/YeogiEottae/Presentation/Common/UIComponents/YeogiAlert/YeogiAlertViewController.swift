//
//  YeogiAlertViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/19/24.
//

import UIKit
import SnapKit

protocol YeogiAlertViewControllerDelegate: AnyObject {
    func didDeleteRoom()
}

final class YeogiAlertViewController: UIViewController {
    
    weak var delegate: YeogiAlertViewControllerDelegate?
    private let alertView = YeogiAlertView()
    var roomId: Int?
    
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
        alertView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: false)
    }
    
    @objc private func deleteButtonTapped() {
        deleteCompareLikeData()
        self.delegate?.didDeleteRoom()
        self.dismiss(animated: false)
    }
    
    private func deleteCompareLikeData() {
        CompareService.shared.deleteLikeCompareData(request: DeleteLikeRoomRequestDTO(roomId: self.roomId ?? 0)) { [weak self] response in
            switch response {
            case .success(let data):
                if let data = data as? DeleteLikeRoomResponseDTO {
                }
                
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
}
