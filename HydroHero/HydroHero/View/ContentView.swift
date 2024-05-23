//
//  ContentView.swift
//  HydroHero
//
//  Created by user235477 on 3/8/23.
//

import SwiftUI
    
    struct ContentView: View {
        @StateObject var todo = Todo()

        var body: some View {
            TabView {
                Acceuil()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Acceuil")
                    }
                    .environmentObject(todo)
                
                Suivi()
                    .tabItem {
                        Image(systemName: "cursorarrow.click.badge.clock")
                        Text("Suivi")
                    }
                    .environmentObject(todo)		
                Parametres()
                    .tabItem {
                        Image(systemName: "slider.horizontal.3")
                        Text("Paramètres")
                    }
                    .environmentObject(todo)
            }
        }
    }




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
