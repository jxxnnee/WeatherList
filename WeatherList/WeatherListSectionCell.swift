//
//  WeatherListSectionCell.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/13.
//

import UIKit

class WeatherListSectionCell: UITableViewCell {
    public var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.subviews.forEach { view in
            if String(describing: type(of: view)) == "_UITableViewCellSeparatorView" {
                view.alpha = 0.0
            }
        }
    }
}
