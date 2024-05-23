//
//  ViewB.swift
//  HydroHero
//
//  Created by user235477 on 3/8/23.
//

import SwiftUI

struct Parametres: View {
    
    @EnvironmentObject var todo : Todo
    
    @State private var languageSelection = "Français"
    @State private var genderSelection = "Homme"
    @State private var weightInput = ""
    @State private var mlGoalInput = ""
    @State private var bottleVolumeSelection = 0
    			
    	
    var body: some View {
        NavigationView {
        VStack {
            Text("Paramètres")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            
            Section() {
                Text("Langue: \(languageSelection)")
                Picker(selection: $languageSelection, label: Text("Langue")) {
                    ForEach(todo.languageOptions, id: \.self) { language in
                        Text(language)
                    }
                }
                Text("Sexe : \(genderSelection)")
                Picker(selection: $genderSelection, label: Text("Sexe"))
                {
                    ForEach(todo.genderOptions, id: \.self) { gender in
                        Text(gender)
                    }
                }
                
                HStack {
                    Text("Poids (en kg) :")
                        .padding()
                    Text("\(weightInput)")
                    Text("Kg")
                }
                Slider(value: Binding(
                    get: { Double(weightInput) ?? 0.0 },
                    set: { weightInput = String(Int($0)) }
                ), in: 0...300, step: 1, label: {
                    Text("Poids (en kg)")
                })
                Spacer()
                
                
                
                
                Text("Votre objectif :")
                Stepper(value: Binding(
                    get: { Int(mlGoalInput) ?? 0 },
                    set: { mlGoalInput = String($0) }
                ), in: 0...5000, step: 100, label: {
                    TextField("Objectif (en ml)", text: $mlGoalInput )
                })

                
            }.font(.system(size: 25))
            Spacer()
                    
                    
                    Section(header: Text("Volume conteneur")) {
                        HStack{
                            
                        
                             Text("Verre").foregroundColor(Color.blue)
                                .padding(10)
                            Picker(selection: $todo.glassVolumeSelection, label: Text("Verre")) {
                                ForEach(todo.glassVolumes.indices, id: \.self) { index in
                                    Text("\(todo.glassVolumes[index]) ml")                            }
                                
                        }
                    
                    }
                       
                        
                        HStack{
                            Text("Bouteille").foregroundColor(Color.blue)
                        
                            Picker(selection: $todo.bottleVolumeSelection, label: Text("Bouteille")) {
                            ForEach(todo.bottleVolumes.indices, id: \.self) { index in
                                Text("\(todo.bottleVolumes[index]) ml")
                            }
                        
                        }
                    }
                        
                        
                    }.font(.system(size: 25))
            Spacer()
            
            
            
            NavigationLink(destination: Acceuil()) {
                Button(action: {
                    todo.totalWater = Int(mlGoalInput) ?? 1200
                }) {
                    Text("Valider")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            }
        }
        
        .padding()
        .navigationBarTitle("HydroHero")
        
        
    }
    
}


struct Parametres_Previews: PreviewProvider {
    static var previews: some View {
        Parametres()
            .environmentObject(Todo())
    }
}

