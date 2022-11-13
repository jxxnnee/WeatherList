//
//  Date+Ex.swift
//  WeatherList
//
//  Created by 민경준 on 2022/11/13.
//

import Foundation


struct CalendarWrapper {
    static var `default`: Calendar {
        get {
            var cal = Calendar(identifier: .gregorian)
            cal.locale = Locale.current
            cal.timeZone = TimeZone.autoupdatingCurrent
            
            return cal
        }
    }
}

extension DateFormatter {
    enum Format {
        /// yyyy-MM-dd HH:mm:ss
        case basic
        /// yyyy-MM-dd,a h:mm:s
        case meridiem
        /// yyyy-MM-dd HH:mm
        case withOutSecond
        /// yyyy-MM-dd
        case date
        /// yyyy.MM.dd
        case point
        /// yyyyMMdd
        case noChar
        /// HH:mm
        case time
    }
    
    static let yyyyMMddHHmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
    
    static let yyyyMMddHHmmss: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
    
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
    
    static let yyyyMMddWithOutBars: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
    
    static let yyyyMMddWithPoint: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
    
    static let yyyyMMddaHmms: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd,a h:mm:s"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
    
    static let HHmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.calendar = CalendarWrapper.default
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
 
        return formatter
    }()
}

extension Date {
    internal func toString(_ format: DateFormatter.Format) -> String {
        switch format {
        case .basic:
            return DateFormatter.yyyyMMddHHmmss.string(from: self)
        case .meridiem:
            return DateFormatter.yyyyMMddaHmms.string(from: self)
        case .withOutSecond:
            return DateFormatter.yyyyMMddHHmm.string(from: self)
        case .date:
            return DateFormatter.yyyyMMdd.string(from: self)
        case .point:
            return DateFormatter.yyyyMMddWithPoint.string(from: self)
        case .noChar:
            return DateFormatter.yyyyMMddWithOutBars.string(from: self)
        case .time:
            return DateFormatter.HHmm.string(from: self)
        }
    }
    
    private var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale.current
        cal.timeZone = TimeZone.current
        
        return cal
    }
    
    var year: Int {
        get {
            return self.calendar.component(.year, from: self)
        }
        set {
            guard let date = DateComponents(calendar: self.calendar, year: newValue, month: self.month, day: self.day, hour: self.hour, minute: self.minute).date else { return }
            
            self = date
        }
    }
    
    var day: Int {
        get {
            return self.calendar.component(.day, from: self)
        }
        set {
            guard let date = DateComponents(calendar: self.calendar, year: self.year, month: self.month, day: newValue, hour: self.hour, minute: self.minute).date else { return }
            
            self = date
        }
    }
    
    var month: Int {
        get {
            return self.calendar.component(.month, from: self)
        }
        set {
            guard let date = DateComponents(calendar: self.calendar, year: self.year, month: newValue, day: self.day, hour: self.hour, minute: self.minute).date else { return }
            
            self = date
        }
    }
    
    var weekday: Int {
        get {
            return self.calendar.component(.weekday, from: self)
        }
    }
    
    var hour: Int {
        get {
            return self.calendar.component(.hour, from: self)
        }
        set {
            guard let date = DateComponents(calendar: self.calendar, year: self.year, month: self.month, day: self.day, hour: newValue, minute: self.minute).date else { return }
            
            self = date
        }
    }
    
    var minute: Int {
        get {
            return self.calendar.component(.minute, from: self)
        }
        set {
            guard let date = DateComponents(calendar: self.calendar, year: self.year, month: self.month, day: self.day, hour: self.hour, minute: newValue).date else { return }
            
            self = date
        }
    }
    
    var isLeapMonth: Bool {
        get {
            return self.calendar.dateComponents([.year, .month], from: self).isLeapMonth!
        }
    }
}


extension String {
    internal func toDate(from format: DateFormatter.Format = .basic) -> Date {
        var formatter = DateFormatter.yyyyMMddHHmmss
        switch format {
        case .basic:
            formatter = DateFormatter.yyyyMMddHHmmss
        case .meridiem:
            formatter = DateFormatter.yyyyMMddaHmms
        case .withOutSecond:
            formatter = DateFormatter.yyyyMMddHHmm
        case .date:
            formatter = DateFormatter.yyyyMMdd
        case .point:
            formatter = DateFormatter.yyyyMMddWithPoint
        case .noChar:
            formatter = DateFormatter.yyyyMMddWithOutBars
        case .time:
            formatter = DateFormatter.HHmm
        }
        
        guard let date = formatter.date(from: self) else {
            fatalError("NOT CORRECT FORMAT")
        }
        
        return date
    }
}
