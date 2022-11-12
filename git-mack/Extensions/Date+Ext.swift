//
//  Date+Ext.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        
        return dateFormatter.string(from: self)
    }
}
