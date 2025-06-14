//
//  StationInputView.swift
//  TravelSchedule
//
//  Created by Александр Дудченко on 15.05.2025.
//

import Foundation
import SwiftUI

struct StationInputView: View {
    @Binding var from: String
    @Binding var to: String

    var onFromTap: (() -> Void)? = nil
    var onToTap: (() -> Void)? = nil
    var onFindTap: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 0) {
                    Button(action: {
                        onFromTap?()
                    }) {
                        HStack {
                            Text(from.isEmpty ? "Откуда" : from)
                                .foregroundStyle(from.isEmpty ? Color("Gray Universal") : Color("Black Universal"))
                                .frame(height: 48)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }

                    Button(action: {
                        onToTap?()
                    }) {
                        HStack {
                            Text(to.isEmpty ? "Куда" : to)
                                .foregroundStyle(to.isEmpty ? Color("Gray Universal") : Color("Black Universal"))
                                .frame(height: 48)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                }
                .background(Color("White Universal"))
                .cornerRadius(16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .leading)

                Button(action: {
                    let temp = from
                    from = to
                    to = temp
                }) {
                    Image("change")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("Blue Universal"))
                        .padding(10)
                        .background(Color("White Universal"))
                        .clipShape(Circle())
                }
                .frame(width: 36, height: 36)
            }
            .padding(16)
            .frame(height: 128)
            .background(Color("Blue Universal"))
            .cornerRadius(20)

            if !from.isEmpty && !to.isEmpty {
                Button(action: {
                    onFindTap?()
                }) {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color("White Universal"))
                        .frame(width: 150, height: 60)
                        .background(Color("Blue Universal"))
                        .cornerRadius(16)
                }
            }
        }
        .frame(width: 343)
        .padding(.bottom, 16)
    }
}

#Preview {
    StationInputView(
        from: .constant(""),
        to: .constant(""),
        onFromTap: {},
        onToTap: {},
        onFindTap: {}
    )
}
