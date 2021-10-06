//
//  NoItemsView.swift
//  TodoList
//
//  Created by Steven Yu on 10/5/21.
//

import SwiftUI

struct NoItemsView: View {
    
    // first sets the animate to false
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .padding(.bottom, 20)
                NavigationLink(
                    destination: AddView(),
                    // essentially label goes from big secondary accent color to small accent color
                    label: {
                        Text("Add Something 🥳")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            // animates the background to animates from the secondary accent color and the accent color
                            .background(animate ? secondaryAccentColor : Color.accentColor)
                            .cornerRadius(10)
                    })
                    // makes it so it animates from small padding to big padding
                    // CGFloat cast is to prevent some weird bug lol
                    .padding(.horizontal, animate ? CGFloat(30) : 50)
                    .shadow(
                        // animates it from a semi-opaque secondary accent color and the accent color
                        // matches with the background :)
                        color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                        // animates from big shadow to small shadow
                        // matches with .scaleEffect()
                        radius: animate ? 30 : 10,
                        x: 0.0,
                        // shadow animates from down to up
                        y: animate ? 50 : 30)
                    // animates from big to small
                    .scaleEffect(animate ? 1.1: 1.0)
                    // whole label animates from down to up
                    .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            // when the view appears, calls for addAnimation
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        // if animate is already called, the addAnimation will exit since the animation is already running
        guard !animate else { return }
        // delays to after 1.5 seconds after the func is called
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                // custom animation that eases in and out for 2.0 and repeats forever (self-explanatory ik lol)
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
