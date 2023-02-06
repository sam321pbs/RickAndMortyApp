//
//  RMSettingsView.swift
//  RickAndMortyApp 2.0
//
//  Created by Samuel Mengistu on 1/31/23.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.settingsOptions, id: \.self) { setting in
                HStack {
                    if let image = setting.iconImage {
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .background(Color(setting.iconContainerColor))
                            .cornerRadius(6)
                        
                    }
                    Text(setting.displayTitle)
                        .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding(.bottom, 3)
                .onTapGesture {
                    viewModel.onTappedView(setting: setting)
                    
                }
            }.navigationBarTitle("Settings", displayMode: .large)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(viewModel: RMSettingsViewViewModel())
    }
}
