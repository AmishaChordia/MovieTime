//
//  String+Extension.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

extension String {

    func formatDate(formatter: String =  "MMM dd, yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        if let date = date {
            dateFormatter.dateFormat = formatter
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
