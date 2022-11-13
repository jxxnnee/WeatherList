//
//  WeatherListCell.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/10.
//

import UIKit

class WeatherListCell: UITableViewCell {
    public var today: String = "" {
        didSet {
            self.todayLabel.text = today
        }
    }
    fileprivate var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .black
        
        return label
    }()
    
    fileprivate var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear"
        label.textColor = .black
        
        return label
    }()
    
    public var max: Int = 0 {
        didSet {
            self.maxLabel.text = "Max: \(self.max)°C"
        }
    }
    fileprivate var maxLabel: UILabel = {
        let label = UILabel()
        label.text = "Max: 9°C"
        label.textColor = .black
        
        return label
    }()
    
    public var min: Int = 0 {
        didSet {
            self.minLabel.text = "Min: \(self.min)°C"
        }
    }
    fileprivate var minLabel: UILabel = {
        let label = UILabel()
        label.text = "Min: 9°C"
        label.textColor = .black
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
