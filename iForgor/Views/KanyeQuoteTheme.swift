//
//  KanyeQuoteTheme.swift
//  iForgor
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import SwiftUI

struct KanyeQuoteTheme: View {
    let theme: Theme
    let quote: String
    let refreshButtonTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 24, content: {
            themeBuilder(theme: theme) {
                switch theme {
                case .theme1:
                    Theme1(theme: theme, quote: quote)
                case .theme2:
                    Theme2(theme: theme, quote: quote)
                case .theme3:
                    Theme3(theme: theme, quote: quote)
                case .error:
                    ErrorTheme(theme: .error)
                }
            }
        
            refreshButton
        })
    }
    
    func themeBuilder<Content: View>(theme: Theme, @ViewBuilder content: () -> Content) -> some View{
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                header
                content()
                Spacer()
                footer
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 370)
        .padding(.vertical, 24)
        .padding(.horizontal, 24 + 16)
        .background {
            theme.backgroundColor
        }
        .clipShape(RoundedRectangle(cornerRadius: 30.0))
        .padding(.horizontal, 24)
    }
    
    var refreshButton: some View {
        Button(action: {
            refreshButtonTapped()
        }, label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                    .frame(width: 22, height: 22)
                Text("Refresh")
            }
        })
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(Color(hex: "4592FF"))
        .foregroundStyle(.white)
        .clipShape(Capsule())
    }
    
    var header: some View {
        Text("#iForgor")
            .foregroundStyle(theme.headerColor)
            .font(.system(size: 16))
    }
    
    var footer: some View {
        HStack(alignment: .center) {
            Image(.icKanye)
                .frame(width: 56, height: 56)
        }.frame(maxWidth: .infinity)
    }
}

fileprivate struct Theme1: View {
    var theme: Theme
    var quote: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image(.icQuoteLarge)
                    .frame(width: 70, height: 70)
                Spacer()
            }
            
            VStack(alignment: .leading, content: {
                Text(quote)
                    .foregroundStyle(theme.textColor)
                    .font(.system(size: 25, weight: .black))
                    .minimumScaleFactor(0.1)
                    .padding(.horizontal, 12)
                
                Spacer()
            })
            .padding(.top, 24)
            .padding(.leading, 12)
        }
        .offset(y: 12)
        .frame(height: 235)
    }
}

fileprivate struct Theme2: View {
    var theme: Theme
    var quote: String

    var body: some View {
        VStack(alignment: .leading) {
            Image(.icQuoteSmall)
                .frame(width: 50, height: 50)
                .foregroundStyle(theme.textColor)
            
            Text(quote)
                .foregroundStyle(theme.textColor)
                .font(.system(size: 25, weight: .black))
                .minimumScaleFactor(0.1)
            
            Spacer()
        }
        .frame(height: 245)
    }
}

fileprivate struct Theme3: View {
    var theme: Theme
    var quote: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(quote)
                .foregroundStyle(theme.textColor)
                .font(.system(size: 35, weight: .black))
                .minimumScaleFactor(0.1)
                
            Spacer() 
        }.frame(height: 245)
    }
}

fileprivate struct ErrorTheme: View {
    var theme: Theme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Unable to fetch Mr West’s Quote 🥺")
                .foregroundStyle(theme.textColor)
                .font(.system(size: 20, weight: .black))
                .minimumScaleFactor(0.5)
                
            Spacer()
        }.frame(height: 245)
    }
}

#Preview {
    KanyeQuoteTheme(theme: .theme3,
                    quote: "Be fearful.",
                    refreshButtonTapped: {
        
    })
}
