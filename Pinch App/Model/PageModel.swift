//
//  PageModel.swift
//  Pinch App
//
//  Created by Mary Moreira on 17/10/2022.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
  var thumbnailName: String {
    return "thumb-" + imageName
  }
}
