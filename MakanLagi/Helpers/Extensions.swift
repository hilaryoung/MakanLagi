//
//  Extensions.swift
//  MakanLagi
//
//  Created by Hilary Young on 03/05/2023.
//

import SwiftUI


// sources:
// https://www.youtube.com/watch?v=zW2OCKsmg8c



// MARK: Custom popup view
extension View{
    
    // MARK: Building custom modifier for custom popup view
    func popupNavigationView2<Content: View>(horizontalPadding: CGFloat = 72, show: Binding<Bool>,@ViewBuilder content: @escaping ()->Content)-> some View{
        
        return self
            .overlay{
                if show.wrappedValue{
                    // MARK: Geometry reader for reading geometry frame
                    GeometryReader{ proxy in
                        
                        Color.primary
                            .opacity(0.25)
                            .ignoresSafeArea()
                        
                        let size = proxy.size
                        
                        VStack {
                            content()
                        }
                        .background(.white)
                        .frame(width: size.width - horizontalPadding,height: size.height/1.8, alignment: .center ) // height responsive depending on content()
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                    }
                }
            }
    }
    
}


extension View {
    func popupNavigationView<Content: View>(
        horizontalPadding: CGFloat = 72,
        show: Binding<Bool>,
        verticalSpacer: Binding<CGFloat>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        return self.overlay {
            if show.wrappedValue {
                GeometryReader { proxy in
                    Color.primary
                        .opacity(0.25)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    VStack(alignment: .center) {
                        Spacer().frame(height: verticalSpacer.wrappedValue)
                        
                        ScrollView {
                            VStack {
                                content()
                            }
                            .background(Color.white)
                            .frame(width: size.width - horizontalPadding, alignment: .center)
                            .cornerRadius(16)
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}





//.frame(width: size.width - horizontalPadding,height: size.height/1.8, alignment: .center ) // height responsive depending on content()



// MARK: Custom HEX Color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b, a: Double
        switch hex.count {
        case 3:
            r = Double((int >> 8) & 0xF) / 15
            g = Double((int >> 4) & 0xF) / 15
            b = Double((int >> 0) & 0xF) / 15
            a = 1
        case 4:
            r = Double((int >> 12) & 0xF) / 15
            g = Double((int >> 8) & 0xF) / 15
            b = Double((int >> 4) & 0xF) / 15
            a = Double((int >> 0) & 0xF) / 15
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double((int >> 0) & 0xFF) / 255
            a = 1
        case 8:
            r = Double((int >> 24) & 0xFF) / 255
            g = Double((int >> 16) & 0xFF) / 255
            b = Double((int >> 8) & 0xFF) / 255
            a = Double((int >> 0) & 0xFF) / 255
        default:
            r = 0
            g = 0
            b = 0
            a = 0
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}


// MARK: Date to Words
func dateToWords(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE MMM d, yyyy"
    return dateFormatter.string(from: date)
}


// MARK: Custom Corners
struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}


// MARK: Level color code
func getColor(for difficulty: String) -> Color {
    switch difficulty {
    case "Easy":
        return Color(hex: "FBA8B7")
    case "Medium":
        return Color(hex: "E39D01")
    case "Hard":
        return Color(hex: "F15533")
    case "Mudah":
        return Color(hex: "FBA8B7")
    case "Sedang":
        return Color(hex: "E39D01")
    case "Sulit":
        return Color(hex: "F15533")
    default:
        return Color(hex: "F15533")
    }
}


// MARK: Hide Keybaord when user tap beyond search bar
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


