//
//  FilterView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 01.06.2025.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    @StateObject private var filterViewModel = FilterViewModel()
    @State private var navigateToResult = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme


    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))

            ForEach(filterViewModel.timeOptions, id: \.self) { option in
                HStack {
                    Text(option)
                        .font(.system(size: 17, weight: .regular))
                        .kerning(-0.41)
                    Spacer()
                    Image(filterViewModel.selectedTimes.contains(option) ? "checkbox_on" : "checkbox_off")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            filterViewModel.toggleTimeOption(option)
                        }
                }
            }

            Text("Показывать варианты с пересадками")
                .font(.system(size: 24, weight: .bold))

            HStack {
                Text("Да")
                    .font(.system(size: 17, weight: .regular))
                    .kerning(-0.41)
                Spacer()
                Image(filterViewModel.showTransfers == true ? "radio_on" : "radio_off")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        filterViewModel.setTransfers(true)
                    }
            }

            HStack {
                Text("Нет")
                    .font(.system(size: 17, weight: .regular))
                    .kerning(-0.41)
                Spacer()
                Image(filterViewModel.showTransfers == false ? "radio_on" : "radio_off")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        filterViewModel.setTransfers(false)
                    }
            }

            Spacer()

            if filterViewModel.isApplyButtonEnabled {
                Button(action: {
                    travelViewModel.selectedTimes = filterViewModel.selectedTimes
                    travelViewModel.allowTransfers = filterViewModel.showTransfers
                    navigateToResult = true
                }) {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 343, height: 60)
                        .background(Color("Blue Universal"))
                        .cornerRadius(16)
                }
                .padding(.horizontal, 8)
                .padding(.top, 20)
                .padding(.bottom, 20)
            }
        }
        .padding(16)
        .navigationBarBackButtonHidden(false)
        .navigationDestination(isPresented: $navigateToResult) {
            FilteredResultView()
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            navigateToResult = false
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(colorScheme == .dark ? Color("White Universal") : Color("Black Universal"))
                        }
                    }
                }
        }
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        FilterView().environmentObject(TravelViewModel())
    }
}
