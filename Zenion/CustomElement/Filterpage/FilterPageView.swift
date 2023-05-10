//
//  FilterPageView.swift
//  Zenion
//
//  Created by macbook on 29.04.23.
//

import SwiftUI

struct FilterPageView: View {
   var body: some View {
            ZStack {
                Color("light-brown")
                    .navigationTitle("Filters")
                    .ignoresSafeArea()
                ProgressView()
         }
    }
}
struct FilterPageView_Previews: PreviewProvider {
    static var previews: some View {
        FilterPageView()
    }
}
struct ProgressView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = FilterViewModel()
    private let titles = ["All", "Movies", "TV Series"]
    private var genreValue = "All"
    private var countryValue = "All"
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    @State private var callIndex = 0
    @State private var ActivityIndicator = false
    @State private var showGreeting = true
    @State private var yearSliderBool = false
    @State private var yeariconImage = "chevron.forward"
    @State private var yeariconText = "All"
    @State private var ratingSliderBool = false
    @State private var ratingiconImage = "chevron.forward"
    @State private var ratingiconText = "All"
    @State private var range = 1900...Calendar.current.component(.year, from: Date())
    @State var yearsliderPosition: ClosedRange<Float> = 1900...Float(Calendar.current.component(.year, from: Date()))
    @State var ratingliderPosition: ClosedRange<Float> = 0...10
    @State private var color = Color.purple
    @State private var selectedIndex = 0
    @State private var selectedGenre = "All"
    @State private var selectedCountry = "All"
    @State private var frames = Array<CGRect>(repeating: .zero, count: 3)
    var body: some View {
       let genre = viewModel.genre
        let country = viewModel.country
        VStack {
            VStack {
                Divider()
                HStack {
                    ForEach(titles.indices, id: \.self) { index in
                        Button(action: {
                            selectedIndex = index
                        }) {
                            Text(titles[index])
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
                        .background(
                            GeometryReader { geo in
                                Color.clear.onAppear { setFrame(index: index, frame: geo.frame(in: .global)) }
                            })
                    }
                }
                .background(
                    Capsule()
                        .fill(color)
                        .frame(width: frames[selectedIndex].width, height: frames[selectedIndex].height, alignment: .topLeading)
                        .offset(x: frames[selectedIndex].minX - frames[0].minX),
                    alignment: .leading
                )
                .animation(.default, value: selectedIndex)
            }
            List {
                    Picker("Genre", selection: $selectedGenre) {
                          ForEach(genre, id: \.self) {
                              Text($0)
                          }
                      }
                    .listRowBackground(Color("Gray"))
                      .pickerStyle(.navigationLink)
                      Picker("Country", selection: $selectedCountry) {
                          ForEach(country, id: \.self) {
                              Text($0)
                          }
                      }
                      .listRowBackground(Color("Gray"))
                      .pickerStyle(.navigationLink)
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)){
                            yearSliderBool.toggle()
                        }
                        if yearSliderBool{
                            yeariconText = ""
                            yeariconImage = "chevron.up"
                        }
                        else{
                            yeariconText = "All"
                            yeariconImage = "chevron.forward"
                        }
                    } label: {
                        HStack{
                            Text("Year")
                                .foregroundColor(.blue)
                            Spacer()
                            Text(yeariconText)
                                .foregroundColor(.blue)
                            Image(systemName: yeariconImage)
                                .foregroundColor(.indigo)
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.black)
                        if yearSliderBool{
                            RangedSliderView(value: $yearsliderPosition, bounds: range)
                        }
                    }
                    .listRowBackground(Color("Gray"))
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)){
                            ratingSliderBool.toggle()
                        }
                        if ratingSliderBool{
                            ratingiconText = ""
                            ratingiconImage = "chevron.up"
                        }
                        else{
                            ratingiconText = "All"
                            ratingiconImage = "chevron.forward"
                        }
                    } label: {
                        HStack{
                            Text("Rating")
                            .foregroundColor(.blue)
                            Spacer()
                            Text(ratingiconText)
                                .foregroundColor(.blue)
                            Image(systemName: ratingiconImage)
                                .foregroundColor(.indigo)
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.black)
                        if ratingSliderBool{
                                RangedSliderView(value: $ratingliderPosition, bounds: 0...10)
                        }
                    }
                    .listRowBackground(Color("Gray"))
            }
                  .foregroundColor(.blue)
                  .background(.clear)
                  .scrollContentBackground(.hidden)
                  .scrollDisabled(true)
                  .frame(height: 250)
        List{
            Toggle("Hide viewed", isOn: $showGreeting)
                .toggleStyle(SwitchToggleStyle(tint: .purple))
                .listRowBackground(Color("Gray"))
        }
        .foregroundColor(.blue)
              .background(.clear)
              .scrollContentBackground(.hidden)
              .scrollDisabled(true)
        .frame(height: 80)
        Spacer()
            HStack{
                CustomButton(text: "Filter", color: Color("buttoncollor"), Width: 150, Height: 45) {
                    let myFilter = filterMovies(type: selectedIndex, genre: selectedGenre, country: selectedCountry, minYear: Int(yearsliderPosition.lowerBound), maxYear: Int(yearsliderPosition.upperBound), minRating: Double(Int(ratingliderPosition.lowerBound)), maxRating: Double(Int(ratingliderPosition.upperBound)), hideViewing: showGreeting)
                    if let encoded = try? encoder.encode(myFilter) {
                        defaults.set(encoded, forKey: "filterMovies")
                    }
                    ActivityIndicator = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.presentationMode.wrappedValue.dismiss()
                        ActivityIndicator = false
                }
            }
        }
        Divider()
        }.onAppear{
            if callIndex == 0{
                callIndex  = 1
                selectedIndex = viewModel.type
                selectedGenre = viewModel.genres
                selectedCountry = viewModel.countrys
                if viewModel.minYear != 0 && viewModel.maxYear != 0{
                    yearsliderPosition = Float(viewModel.minYear)...Float(viewModel.maxYear)
                }
                if  viewModel.maxRating != 0{
                    ratingliderPosition = Float(viewModel.minRating)...Float(viewModel.maxRating)
                }
                showGreeting = viewModel.hideViewing
            }
        }
        .overlay(
           HStack{
               if ActivityIndicator {
                   Zenion.ActivityIndicator(isAnimating: true)
                       .foregroundColor(.red)
                       .frame(width: 80)
               }
           })
    }
    private func setFrame(index: Int, frame: CGRect) {
        frames[index] = frame
    }
}

