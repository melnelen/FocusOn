//
//  Goal.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 07/02/2022.
//

import SwiftUI

struct Goal: Identifiable {
    let id = UUID()
    var name: String = ""
    var completionStatus: Bool = false
    var tasks = [Task(), Task(), Task()]
}

