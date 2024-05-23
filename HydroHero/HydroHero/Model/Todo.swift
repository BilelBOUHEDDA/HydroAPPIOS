//
//  Todo.swift
//  TodoA3-A4
//
//  Created by David Laiymani on 22/02/2023.
//

import Foundation
import Combine

class Todo: ObservableObject {
    var id = UUID()
    @Published var totalWater = 1200
    @Published var drankWater = 0
    @Published var goal: Int = 2000 // objectif quotidien
    
    let glassVolumes = [200, 250, 300, 350]
    let bottleVolumes = [500, 750, 1000, 1500]
    let languageOptions = ["Français", "Anglais"]
    let genderOptions = ["Homme", "Femme"]
    var glassVolumeSelection = 0
    var bottleVolumeSelection = 0
    init() {}
    
}
