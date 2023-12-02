//
//  LaunchScreenView.swift
//  SpendyApp
//
//  Created by A B on 01.12.2023.
//

import SwiftUI

struct LaunchScreen: View {
  @State private var isActive = false
  @State private var opacity = 0.0
  @Environment(\.verticalSizeClass)
  var verticalSizeClass
  var body: some View {
    if isActive {
      ContentView()
    } else {
      ZStack {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 645, height: 1398)
          .background(
            Image(verticalSizeClass == .compact ? "launch.screen.landscape" : "launch.screen.portrait")
              .flipsForRightToLeftLayoutDirection(true)
          )
          .background(
            AngularGradient(
              stops: [
                Gradient.Stop(color: .white, location: 0.00),
                Gradient.Stop(color: .black, location: 0.11),
                Gradient.Stop(color: .white, location: 0.20),
                Gradient.Stop(color: .black, location: 0.35),
                Gradient.Stop(color: .white, location: 0.43),
                Gradient.Stop(color: .black, location: 0.54),
                Gradient.Stop(color: .white, location: 0.66),
                Gradient.Stop(color: .black, location: 0.80),
                Gradient.Stop(color: .white, location: 0.97)
              ],
              center: UnitPoint(x: 0.5, y: 0.5),
              angle: Angle(degrees: 90)
            )
          )
          .background(
            AngularGradient(
              stops: [
                Gradient.Stop(color: .white, location: 0.00),
                Gradient.Stop(color: .black, location: 0.11),
                Gradient.Stop(color: .white, location: 0.20),
                Gradient.Stop(color: .black, location: 0.35),
                Gradient.Stop(color: .white, location: 0.43),
                Gradient.Stop(color: .black, location: 0.54),
                Gradient.Stop(color: .white, location: 0.66),
                Gradient.Stop(color: .black, location: 0.80),
                Gradient.Stop(color: .white, location: 0.97)
              ],
              center: UnitPoint(x: 0.5, y: 0.5),
              angle: Angle(degrees: 90)
            )
          )
          .background(
            EllipticalGradient(
              stops: [
                Gradient.Stop(color: Color(red: 0.13, green: 0.67, blue: 0.87), location: 0.00),
                Gradient.Stop(color: Color(red: 0.88, green: 0.96, blue: 0.39), location: 0.24),
                Gradient.Stop(color: Color(red: 1, green: 0.69, blue: 1), location: 0.48),
                Gradient.Stop(color: Color(red: 0.67, green: 0.7, blue: 0.99), location: 0.66),
                Gradient.Stop(color: Color(red: 0.36, green: 0.97, blue: 0.64), location: 0.88),
                Gradient.Stop(color: Color(red: 0.35, green: 0.77, blue: 0.96), location: 1.00)
              ],
              center: UnitPoint(x: 0, y: 0)
            )
          )
        VStack {
          Image("receipt.icon")
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
            .opacity(0.8)
          Text("Spendy".uppercased())
            .font(.largeTitle)
            .foregroundStyle(.black)
            .fontWeight(.heavy)
            .italic()
            .opacity(0.8)
        }
        .opacity(opacity)
        .onAppear {
          withAnimation(.easeIn(duration: 1.2)) {
            self.opacity = 1.0
          }
        }
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
          withAnimation {
            self.isActive = true
          }
        }
      }
    }
  }
}

struct LaunchScreen_Previews: PreviewProvider {
  static var previews: some View {
    LaunchScreen()
  }
}
