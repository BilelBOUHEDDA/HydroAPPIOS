//
//  ViewB.swift
//  HydroHero
//
//  Created by user235477 on 3/23/23.
//

import SwiftUI

struct Suivi: View {
    @EnvironmentObject var todo: Todo

    var body: some View {
        VStack {
            Text("Vous avez bu \(todo.drankWater) mL d'eau aujourd'hui.")
                .font(.title)
                .padding()

            if todo.drankWater < todo.totalWater {
                Text("Il vous reste \(todo.totalWater - todo.drankWater) mL à boire pour atteindre votre objectif quotidien.")
                    .font(.headline)
                    .padding()
            } else {
                Text("Vous avez atteint votre objectif quotidien de \(todo.totalWater) mL !")
                    .font(.headline)
                    .padding()
            }
        }
    }
}




struct Suivi_Previews: PreviewProvider {
    static var previews: some View {
        Suivi()
            .environmentObject(Todo())
    }
}
