//
//  Enums.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 9.12.2022.
//

import Foundation

enum SiralamaMenu: Int {
    
    case SortByName = 0
    case SortByRatinCount = 1
    case SortByReleased = 2
    case SortyByPlaytime = 3
    
    var description: String {
        switch self {
        case .SortByName:
            return "Sort By Name"
        case .SortByRatinCount:
            return "Sort By Rating Count"
        case .SortByReleased:
            return "Sort By Released Time"
        case .SortyByPlaytime:
            return "Sort By PlayTime"
        }
    }
}
enum HomeSectionType: Int, CaseIterable {
    case newGames = 0
    case allGames = 1
    case topRatedGames = 2
    var descripton: String {
        switch self {
        case .newGames:
            return "new games"
        case .allGames:
            return "all games"
        case .topRatedGames:
            return "top rated games"
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
