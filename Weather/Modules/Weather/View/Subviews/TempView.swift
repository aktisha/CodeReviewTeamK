//
//  TempView.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import UIKit
import SnapKit

class TempView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = R.color.secondaryLabel()
        
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        
        return label
    }()
    
    private func setupViews() {
        layer.cornerRadius = 6
        backgroundColor = R.color.secondaryBackground()
        
        [typeLabel, valueLabel].forEach(addSubview)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        typeLabel.snp.remakeConstraints {
            $0.top.equalTo(12)
            $0.leading.equalTo(12)
            $0.trailing.equalTo(-12)
        }
        
        valueLabel.snp.remakeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom).offset(8)
            $0.leading.equalTo(12)
            $0.trailing.equalTo(-12)
            $0.bottom.equalTo(-12)
        }
    }
    
    func configure(type: String, value: String?) {
        typeLabel.text = type
        valueLabel.text = value
    }
    
}
