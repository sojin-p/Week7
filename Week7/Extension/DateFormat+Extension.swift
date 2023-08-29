//
//  DateFormat+Extension.swift
//  Week7
//
//  Created by 박소진 on 2023/08/29.
//

import Foundation

extension DateFormatter {
    
    static let format = {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        return format
    }()
    
    static func today() -> String { //오늘 날짜를 변환하는 메서드
        return format.string(from: Date())
    }
    
    static func convertDate(date: Date) -> String { //선택하는 날짜 변환하는 메서드
        return format.string(from: date)
    }
    
}
