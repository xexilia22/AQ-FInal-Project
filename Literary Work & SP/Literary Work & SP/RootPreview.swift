//
//  RootPreview.swift
//  Literary Work & SP
//
//  Created by 刘嘉欣 on 12/17/24.
//

import Foundation
import SwiftUI

struct RootPreview: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(UserManager())
    }
}
