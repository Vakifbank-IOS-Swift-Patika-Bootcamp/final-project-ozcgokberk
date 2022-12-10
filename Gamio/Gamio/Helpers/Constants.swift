//
//  Constants.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import UIKit
struct Constants {
    static let API_KEY = "c3eccb944689454da36e586efd3f3259"
    static func formatDate(from dateString: String) -> String? {
        let date = dateString.convertDateString()
        if let date = date {
            return date.convertToString()
        }
        return nil
    }
}

extension Date {
    func convertToString(dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        dateFormatter.locale = Locale(identifier: "tr_TR")
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
}


extension String {
    func convertDateString() -> Date? {
        return convert(dateString: self, fromDateFormat: "yyyy-MM-dd", toDateFormat: "dd MM yyyy")
    }
    
    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> Date? {
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat
        
        if let fromDateObject = fromDateFormatter.date(from: dateString) {
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat
            return fromDateObject
        }
        return nil
    }
}

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        return dateFormatter.string(from: self)
    }
}
