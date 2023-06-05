//
//  DefaultViews.swift
//  MakanLagi
//
//  Created by Hilary Young on 03/05/2023.
//

import SwiftUI

// MARK: Page Headers
struct ViewHeader: View {
    var label: String
    
    var body: some View {
        VStack {
            Text(label)
                .font(.custom("SourceSansPro-SemiBold", size: 16))
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "F15533"))
                .foregroundColor(.white)
                .cornerRadius(100)
        }
    }
}


// MARK: Components for Leftover card

struct CompleteLOButton: View {
    var expDate: Date
    var colHex: String
    var shadowHex: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: colHex))
                .overlay(
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                )
        }
        .frame(width: 42, height: 42)
        //.shadow(color: Color(hex: shadowHex).opacity(0.20), radius: 5, x: 0, y: 4)
    }
}


func daysLeft(expDate: Date) -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.day, .hour], from: currentDate, to: expDate)
    
    // Show # of days left if item expires in more than 1 day
    if let daysLeft = components.day, daysLeft > 0 {
        return "\(daysLeft) day\(daysLeft == 1 ? "" : "s") left"
        // Show # of hours left if item expires in 1 day
    } else if let hoursLeft = components.hour, hoursLeft > 0 {
        return "\(hoursLeft) hour\(hoursLeft == 1 ? "" : "s") left"
        // Show "overdue" text if item passed set expiration date
    } else {
        return "Overdue"
    }
}


// color for button commands
func dateControlColor1(dependency: Date) -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.day, .hour], from: currentDate, to: dependency)
    
    // Tag color "Blue" if item expires in more than 1 day
    if let daysLeft = components.day, daysLeft > 0 {
        return "816D54"
        // Tag color "Red" if item expires in 1 day (text displayed as hours left)
    } else if let hoursLeft = components.hour, hoursLeft > 0 {
        return "F15533"
        // Tag color "Red" if item passed set expiration date
    } else {
        return "F15533"
    }
}

// overlay: tag & progress bar
func dateControlColor2(dependency: Date) -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.day, .hour], from: currentDate, to: dependency)
    
    // Tag color "Blue" if item expires in more than 1 day
    if let daysLeft = components.day, daysLeft > 0 {
        return "748FCE"
        // Tag color "Red" if item expires in 1 day (text displayed as hours left)
    } else if let hoursLeft = components.hour, hoursLeft > 0 {
        return "F69B88"
        // Tag color "Red" if item passed set expiration date
    } else {
        return "F69B88"
    }
}

// color for shadow
func dateControlColor3(dependency: Date) -> String {
    let currentDate = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.day, .hour], from: currentDate, to: dependency)
    
    // Tag color "Blue" if item expires in more than 1 day
    if let daysLeft = components.day, daysLeft > 0 {
        return "272E6C"
        // Tag color "Red" if item expires in 1 day (text displayed as hours left)
    } else if let hoursLeft = components.hour, hoursLeft > 0 {
        return "6B0000"
        // Tag color "Red" if item passed set expiration date
    } else {
        return "6B0000"
    }
}



// Edit button
struct EditExpDays: View {
    var expDate = Date()
    
    var body: some View {
        HStack{
            Text(daysLeft(expDate: expDate))
                .font(.custom("Montserrat-Regular", size: 12, relativeTo: .caption))
                //.font(.caption)
                .foregroundColor(expDate.timeIntervalSinceNow <= 86400 ? Color(hex: "3A290E") : Color(hex: "3A290E"))
            Image(systemName: "pencil")
                .foregroundColor(expDate.timeIntervalSinceNow <= 86400 ? Color(hex: "3A290E") : Color(hex: "3A290E"))
                .font(.system(size: 16, weight: .bold))
                .imageScale(.small)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Color(hex: expDate.timeIntervalSinceNow <= 86400 ? "EEE6DA" : "EEE6DA"))
        .cornerRadius(100)
        //.shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
    }
}


// progress bar
struct CountdownProgressBarView: View {
    var startDate: Date
    var endDate: Date
    var barHex: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color(hex: "E8E8E8"))
                    .frame(width: geometry.size.width, height: 8)
                    .cornerRadius(100)
                Rectangle()
                    .foregroundColor(Color(hex: barHex))
                    .frame(width: self.progressWidth(in: geometry.size.width), height: 8)
                    .cornerRadius(100)
                Circle()
                    .foregroundColor(Color(hex: barHex))
                    .frame(width: 14, height: 14)
                    .position(x: self.progressWidth(in: geometry.size.width)-7, y:7)
            }
        }
    }
    
    func daysLeft2() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: Date(), to: endDate)
        return components.hour ?? 0
    }
    
    func progressWidth(in totalWidth: CGFloat) -> CGFloat {
        let hoursLeft = daysLeft2()
        var progress: CGFloat = 0
        
        if hoursLeft <= 1 {
            progress = 1.0
        }else if hoursLeft <= 6 {
            progress = 0.95
        } else if hoursLeft <= 12 {
            progress = 0.85
        } else if hoursLeft <= 24 {
            progress = 0.70
        } else if hoursLeft <= 48 {
            progress = 0.60
        } else if hoursLeft <= 74 {
            progress = 0.50
        } else {
            let totalDays = endDate.timeIntervalSince(startDate) / (60 * 60 * 24)
            let elapsedDays = Double(daysLeft2()) / 24.0
            progress = CGFloat(1.0 - (elapsedDays / totalDays))
            progress = max(0.1, progress + 0.1) // Add 10% and ensure it's at least 10%
        }
        
        return totalWidth * progress
    }
}







// MARK: Close button
struct CloseButton: View {

    let buttonSize: Int
    let icSize: Int
    let backHex: String
    let lineHex: String
    let icHex: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: backHex))
                .overlay(Circle().stroke(Color(hex: lineHex), lineWidth: 2))
            Image(systemName:"xmark")
                .foregroundColor(Color(hex: icHex))
                .frame(width: CGFloat(icSize), height: CGFloat(icSize))
                .zIndex(1)
        }
        .frame(width: CGFloat(buttonSize), height: CGFloat(buttonSize))
    }
}



// MARK: BUTTONS

// MARK: Default [active]
struct DefaultActiveButton: View {
    var label: String
    var backHex: String
    var textHex: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                //.bold()
            Image(systemName: "sparkles")
        }
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(hex: textHex))
        .background(Color(hex: backHex))
        .cornerRadius(100)
    }
}

// MARK: Default [disabled]
struct DefaultDisableButton: View {
    var label: String
    var backHex: String
    var textHex: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                //.bold()
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(hex: textHex))
                .background(Color(hex: backHex))
                .cornerRadius(100)
                .disabled(true)
        }
    }
}


// MARK: BIN BUTTON
struct BinButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(hex: "3A290E"))
            .frame(width: 46, height: 46)
            .overlay(
                Image(systemName: "trash")
                    .foregroundColor(.white)
            )
    }
}



// MARK: TEXT FIELDS
struct DefaultTextField: View {
    
    var title: String
    var placeholder: String
    @Binding var bindingValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.custom("Montserrat-SemiBold", size: 16))
                    .foregroundColor(Color(hex: "3A290E"))
                Spacer()
                TextField(placeholder, text: $bindingValue)
                    .font(.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .accentColor(Color(hex: "F15533"))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(height: 56)
        .background(Color(hex: "EEE6DA"))
        .cornerRadius(100)
        //.shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 4)
    }
}

// MARK: SECURE TEXT FIELDS
struct DefaultSecureField: View {
    
    var title: String
    var placeholder: String
    @Binding var bindingValue: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.custom("Montserrat-SemiBold", size: 16))
                    .foregroundColor(Color(hex: "3A290E"))
                Spacer()
                SecureField(placeholder, text: $bindingValue)
                    .font(.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .accentColor(Color(hex: "F15533"))
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(height: 56)
        .background(Color(hex: "EEE6DA"))
        .cornerRadius(100)
        //.shadow(color: Color.black.opacity(0.02), radius: 4, x: 0, y: 4)
    }
}



// MARK: Sign in/Sign Up button
struct DefaultAuthButton: View {
    var label: String
    var backHex: String
    var textHex: String
    
    var body: some View {
        //HStack{
            //Spacer()
            
            VStack {
                ZStack{
                    HStack{
                        Text(label)
                            .font(.custom("Montserrat-SemiBold", size: 16, relativeTo: .body))
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 46)
            .background(Color(hex: backHex))
            .foregroundColor(Color(hex: textHex))
            .cornerRadius(100)
            .fixedSize(horizontal: true, vertical: false)
            
            //Spacer()
        //}
    }
}


// MARK: SMALL NEXT BUTTON
struct SmallNextButton: View {
    var label: String
    
    var body: some View {
        //HStack{
            //Spacer()
            
            VStack {
                ZStack{
                    HStack{
                        Text(label)
                            .font(.custom("Montserrat-Regular", size: 14, relativeTo: .body))
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(Color(hex: "3A290E"))
            .foregroundColor(Color(hex: "fff"))
            .cornerRadius(100)
            .fixedSize(horizontal: true, vertical: false)
            
            //Spacer()
        //}
    }
}

// MARK: MEDIUM NEXT BUTTON
struct MediumNextButton: View {
    var label: String
    
    var body: some View {
            VStack {
                ZStack{
                    HStack{
                        Text(label)
                            .font(.custom("Montserrat-Regular", size: 16, relativeTo: .body))
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 28)
            .background(Color(hex: "3A290E"))
            .foregroundColor(Color(hex: "fff"))
            .cornerRadius(100)
            .fixedSize(horizontal: true, vertical: false)
    }
}


