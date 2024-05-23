//
//  ViewA.swift
//  HydroHero
//
//  Created by user235477 on 3/8/23.
//

import SwiftUI

struct Acceuil: View {
    
    @State var percent: CGFloat = 0
    @State var selectedImageIndex = 0 // track selected image index
    @State var showCompletionPopup = false // track whether to show completion popup
    @State var glassVolumeSelection = 0
    @State var bottleVolumeSelection = 0
    let images = ["Verre", "Bouteille"] // array of image names
    @State var customWaterAmount: String = ""

    @EnvironmentObject var todo: Todo
  	

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                TabView(selection: $selectedImageIndex) { // use TabView to create carousel
                    ForEach(0..<2) { index in
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8) // set image size
                            .tag(index) // set tag to index for TabView selection
                            .onTapGesture {
                                self.selectedImageIndex = index // set selected image index
                                if images[index] == "Verre" {
                                    self.todo.drankWater += self.todo.glassVolumes[self.todo.glassVolumeSelection] // add selected glass volume to drankWater
                                } else if images[index] == "Bouteille" {
                                    self.todo.drankWater += self.todo.bottleVolumes[self.todo.bottleVolumeSelection] // add selected bottle volume to drankWater
                                }
                                self.percent = CGFloat(self.todo.drankWater) / CGFloat(self.todo.totalWater) // update progress bar
                                if self.percent > 1 {
                                    self.percent = 1
                                    self.showCompletionPopup = true // set completion popup to show
                                }
                            }

            
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // remove TabView index display
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always)) // show page indicators
                .padding(.top, 20)
                
                VStack(alignment: .center, spacing: 10) {
                    CustomProgressView(percent: self.$percent, totalWater: todo.totalWater)

                    
                    
                    if images[selectedImageIndex] == "Verre" {
                        Text("Verre     |     \(todo.glassVolumes[todo.glassVolumeSelection])ml")
                            .font(.title)
                    } else if images[selectedImageIndex] == "Bouteille" {
                        Text("Bouteille     |     \(todo.bottleVolumes[todo.bottleVolumeSelection])ml")
                            .font(.title)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 20)
                
    
            }
            
            if showCompletionPopup {
                ZStack {
                    Color.white.opacity(0.8)
                    VStack {
                        Text("Vous avez atteint vos objectifs d'hydratation du jour, vous ne pouvez plus boire plus !")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: {
                            self.showCompletionPopup = false // close popup
                        }) {
                            Text("OK")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                }
                
                .edgesIgnoringSafeArea(.all)
            }
            HStack {
                    TextField("Entrez la quantité d'eau en mL", text: $customWaterAmount)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Button(action: {
                        if let waterAmount = Int(customWaterAmount) {
                            todo.drankWater += waterAmount
                            self.percent = CGFloat(todo.drankWater) / CGFloat(todo.totalWater)
                            if self.percent > 1 {
                                self.percent = 1
                                self.showCompletionPopup = true
                            }
                            self.customWaterAmount = "" // Clear the custom water amount field
                        }
                    }) {
                        Text("Ajouter")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
            }
            .padding(.bottom, 450)
            .padding(.leading, 30)
            .padding(.trailing, 30)

        }
        
    }
}












    
    
    
    struct Accueil_Previews: PreviewProvider {
        static var previews: some View {
            Acceuil()
                .environmentObject(Todo())
            
        }
    }

    
    struct CustomProgressView: View {
        @Binding var percent: CGFloat
        let totalWater: Int // Ajouter une propriété pour totalWater

        var body: some View {
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 50)
                }
                Capsule()
                    .fill(LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1")]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: self.calPercent(), height: 50)
                
                // Afficher la quantité d'eau en millilitres
                ZStack {
                    Text("\(Int(self.percent * CGFloat(totalWater))) mL / \(totalWater) mL")
                }.padding(18)
            }.padding(18)
            .cornerRadius(15)
            Spacer()
        }
        
        func calPercent() -> CGFloat {
            let width = UIScreen.main.bounds.width - 35
            return width * self.percent
        }
    }


