//
//  Constants.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import UIKit
struct Constants {
    static let API_KEY = "c3eccb944689454da36e586efd3f3259"
    static func removeHTMLTags(in overview: String) -> String? {
        overview.trimHTMLTags()
    }
}

extension String {
    func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
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
