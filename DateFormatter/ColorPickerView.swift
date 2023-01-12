//
//  ColorPickerView.swift
//  DateFormatter
//
//  Created by Mohammed Almalki on 19/06/1444 AH.
//

import SwiftUI

struct ColorPickerView: View {
    
    @State var currentColor: Color
    
    func convertUIColor (uiColor: UIColor) -> Color {
        return Color(red: Double(uiColor.cgColor.components![0]), green: Double(uiColor.cgColor.components![1]), blue: Double(uiColor.cgColor.components![2]))
    }

    var body: some View {
        VStack {
            Image(systemName: "pencil.slash")
                .font(.system(size: 30).bold())
                .imageScale(.large)
                .foregroundColor(.red)
            
            
            Text("Pick your color")
                .font(.system(size: 25).bold())
                .foregroundColor(.black)
            
            HStack {
                ColorPicker("Color", selection: $currentColor)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
            }
            .padding()
            
            Button {
               //print(currentColor)
            } label: {
                Text("Print color value")
                    .font(.system(size: 18).bold())
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color.white)
            } // MARK: Button
            .padding(.horizontal,30)
            .padding(.top, 1)
            
            VStack {
                let newColor = UIColor(currentColor)
                
                Text(String(newColor.rgb()!)) //
                    .font(.system(size: 20).bold())
                    .foregroundColor(.indigo)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(newColor))
                    .frame(width: 40, height: 40)
                
                //======== To convert it into color type ============
//                let secondColor = convertUIColor(uiColor: newColor)
//
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(secondColor)
//                    .frame(width: 40, height: 40)
                
                let red = Double(newColor.cgColor.components![0])
                let green = Double(newColor.cgColor.components![1])
                let blue = Double(newColor.cgColor.components![2])
                
                Text("red: \(String(red))") //
                    .font(.system(size: 15).bold())
                    .foregroundColor(.indigo)
                
                Text("green: \(String(green))") //
                    .font(.system(size: 15).bold())
                    .foregroundColor(.indigo)
                
                Text("blue: \(String(blue))") //
                    .font(.system(size: 15).bold())
                    .foregroundColor(.indigo)
                
                let color = UIColor(red: red, green: green, blue: blue, alpha: 1) // here you get the value
                
                RoundedRectangle(cornerRadius: 20)
                        .fill(Color(color))
                        .frame(width: 40, height: 40)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.red.opacity(0.2))
            )
            .padding(.top, 20)
            .padding(.bottom, 5)

            
        } // MARK: Vstack
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.yellow.opacity(0.2))
    }
}

extension UIColor {
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            return (red, green, blue, alpha) // "\(red) \(green) \(blue) \(alpha)"
        }
    
    func rgb() -> Int? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return rgb
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

extension Color {
    init(uiColor: UIColor) {
        self.init(red: Double(uiColor.rgba.red),
                  green: Double(uiColor.rgba.green),
                  blue: Double(uiColor.rgba.blue),
                  opacity: Double(uiColor.rgba.alpha))
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(currentColor: .red)
    }
}
