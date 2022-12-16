//
//  Enums.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 9.12.2022.
//

import Foundation
import UIKit

enum SiralamaMenu: Int {
    
    case SortByName = 0
    case SortByRatinCount = 1
    case SortByReleased = 2
    case SortyByPlaytime = 3
    
    var description: String {
        switch self {
        case .SortByName:
            return "sortByNameTxt".localized
        case .SortByRatinCount:
            return "sortByRatingCountTxt".localized
        case .SortByReleased:
             return "sortByReleasedTxt".localized
        case .SortyByPlaytime:
            return "sortByPlaytimeTxt".localized
        }
    }
}

enum HomeSectionType: Int, CaseIterable {
    case newGames = 0
    case allGames = 1
    case topRatedGames = 2
    case gameCategories = 3
    var descripton: String {
        switch self {
        case .newGames:
            return "new games"
        case .allGames:
            return "all games"
        case .topRatedGames:
            return "top rated games"
        case .gameCategories:
            return "gameCategories"
        }
    }
}

enum LanguageEnum: String {
    case TR = "TR"
    case EN = "EN"
    
    var description: String {
        switch self {
        case .TR:
            return "Turkish"
        case .EN:
            return "English"
        }
    }
    var image: UIImage {
        switch self {
        case .TR:
            return UIImage(named: "turkiye")!
        case .EN:
            return UIImage(named: "english")!
        }
    }
}

enum DateFormatType: String {
    
    /// Date with hours dd MMM yyyy H:mm
    case dateWithTime = "dd MMM yyyy H:mm"
    
    /// Date with month And yeard MMM yyyy
    case dateWithMonthYear = "MMM yyyy"
    
    /// Date with hours dd.MM.yyyy - HH:mm
    case dateWithTimeDotWithLine = "dd.MM.yyyy - HH:mm"
    
    /// Date with hours dd MMM yyyy H:mm
    case dateWithTimeWithLine = "dd MMM yyyy - HH:mm"
    
    /// Date dd MMM yyyy
    case date = "dd MMM yyyy"
    
    /// Date dd MMM
    case dateWithMonthAndDay = "dd MMM"
    
    /// Date yyyy-MM-dd
    case dateWithLine = "yyyy-MM-dd"
    
    /// Date dd-MM-yyyy
    case dateWithLineStartingDay = "dd-MM-yyyy"
    
    /// Date dd-MM-yyyy HH:mm
}

enum CommonLocalization {
    case success
    case successContentText
    case error
    case warning
    case errorOccured
    case errorOccuredParsing
    case mustInput
    case done
    
    
    var localized: String {
        switch self {
        case .success:
            return "successText".localized
        case .successContentText:
            return "successContentText".localized
        case .error:
            return "errorText".localized
        case .warning:
            return "warningText".localized
        case .errorOccured:
            return "errorContentText".localized
        case .errorOccuredParsing:
            return "dataParseErrorText".localized
        case .mustInput:
            return "emptyInput".localized
        case .done:
            return "doneText".localized
        }
    }
}
