//
//  String+Ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)!
    }
    
    func toDate() -> String {
        guard let date = self.convertToDate() else { return "시간을 불러올 수 없습니다." }
        return date.convertToString()
    }
}
