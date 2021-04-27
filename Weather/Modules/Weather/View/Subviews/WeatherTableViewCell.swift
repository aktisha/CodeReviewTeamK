//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Kuanysh Anarbay on 19.04.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static let reuseId = String(describing: self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var titleHeader: UIView = UIView()
    
    private lazy var minTempView = TempView()
    
    private lazy var maxTempView = TempView()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var tempTypeView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = R.color.background()
        
        [titleLabel, detailsLabel].forEach(titleHeader.addSubview)
        [minTempView, maxTempView].forEach(tempStackView.addArrangedSubview)
        [tempStackView].forEach(tempTypeView.addSubview)
        [titleHeader, tempTypeView].forEach(stackView.addArrangedSubview)
        [stackView].forEach(contentView.addSubview)
        
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        titleLabel.snp.remakeConstraints {
            $0.leading.equalTo(16)
            $0.centerY.equalToSuperview()
        }
        
        detailsLabel.snp.remakeConstraints {
            $0.trailing.equalTo(-16)
            $0.centerY.equalToSuperview()
        }
        
        titleHeader.snp.remakeConstraints {
            $0.height.equalTo(44)
        }
        
        tempStackView.snp.remakeConstraints {
            $0.top.equalTo(4)
            $0.leading.equalTo(16)
            $0.bottom.equalTo(-12)
            $0.trailing.equalTo(-16)
        }

        stackView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(temperature: Tempetature) {
        titleLabel.text = temperature.dateTime.day
        detailsLabel.text = temperature.temp.degree
        
        tempTypeView.isHidden = temperature.minTemp == nil && temperature.maxTemp == nil
        minTempView.configure(type: "Минимум", value: temperature.minTemp?.degree)
        maxTempView.configure(type: "Максимум", value: temperature.maxTemp?.degree)
    }
}
