//
//  WeatherListCell.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/10.
//

import UIKit
import Kingfisher

class WeatherListCell: UITableViewCell {
    public var today: String = "" {
        didSet {
            let toStr = Date().toString(.noChar)
            let moStr = Calendar.current.date(byAdding: .day, value: 1, to: Date())?.toString(.noChar)
            let dateStr = self.today.toDate(from: .basic).toString(.noChar)
            
            if toStr == dateStr {
                self.todayLabel.text = "Today"
            } else
            if moStr == dateStr {
                self.todayLabel.text = "Tomorrow"
            } else {
                self.todayLabel.text = self.setDateForEng(self.today)
            }
        }
    }
    fileprivate var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .black
        
        return label
    }()
    
    public var weather: String = "" {
        didSet {
            self.weatherLabel.text = self.weather
        }
    }
    fileprivate var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear"
        label.textColor = .black
        
        return label
    }()
    
    public var max: Float = 0.0 {
        didSet {
            let int = Int(round(self.max))
            self.maxLabel.text = "Max: \(int)°C"
        }
    }
    fileprivate var maxLabel: UILabel = {
        let label = UILabel()
        label.text = "Max: 9°C"
        label.textColor = .black
        
        return label
    }()
    
    public var min: Float = 0.0 {
        didSet {
            let int = Int(round(self.min))
            self.minLabel.text = "Min: \(int)°C"
        }
    }
    fileprivate var minLabel: UILabel = {
        let label = UILabel()
        label.text = "Min: 9°C"
        label.textColor = .black
        
        return label
    }()
    
    public var icon: String = "" {
        didSet {
            let url = URL(string: "http://openweathermap.org/img/w/\(icon).png")
            self.iconView.kf.setImage(with: url)
        }
    }
    fileprivate var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    /// 날짜를 영어로 표기하기 위한 함수
    fileprivate func setDateForEng(_ str: String) -> String {
        let date = str.toDate(from: .basic)
        let month = self.setMonth(date)
        let weekday = self.setWeekDay(date)
        
        return "\(weekday) \(date.day) \(month)"
    }
    /// weekDay에 따라서 요일을 영어로 치환하는 함수
    fileprivate func setWeekDay(_ date: Date) -> String {
        switch date.weekday {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "Mon"
        }
    }
    /// month에 따라서 달을 영어로 치환하는 함수
    fileprivate func setMonth(_ date: Date) -> String {
        switch date.month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return "Jan"
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.todayLabel)
        self.todayLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self.contentView).offset(20)
        }
        
        self.contentView.addSubview(self.iconView)
        self.iconView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.top.equalTo(self.todayLabel.snp.bottom).offset(20).priority(.medium)
            make.left.equalTo(self.todayLabel)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.contentView.addSubview(self.weatherLabel)
        self.weatherLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.iconView).offset(-10)
            make.left.equalTo(self.iconView.snp.right).offset(10)
        }
        
        self.contentView.addSubview(self.minLabel)
        self.minLabel.snp.makeConstraints { make in
            make.right.equalTo(self.contentView).inset(20)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
        
        self.contentView.addSubview(self.maxLabel)
        self.maxLabel.snp.makeConstraints { make in
            make.right.equalTo(self.minLabel.snp.left).offset(-10)
            make.centerY.equalTo(self.minLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.iconView.image = nil
        self.todayLabel.text = nil
        self.minLabel.text = nil
        self.maxLabel.text = nil
        self.weatherLabel.text = nil
    }
}
