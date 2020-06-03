//
//  ContentView.swift
//  unitConverter
//
//  Created by Paul Krznaric on 2020-06-03.
//  Copyright © 2020 Krznarnetic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var toConvert = "0"
    @State private var inSelection = 0
    @State private var outSelection = 0
    
    let units = ["Celsius", "Kelvin","Farenheit"]
    
    var converted : Double {
        switch outSelection{
        case 0:
            return toCelsius(toConvert: toKelvin())
        case 1:
            return toKelvin()
        case 2:
            return toFarenheit(toConvert: toKelvin())
        default:
            return 0
        }
        
    }
    
    func toKelvin() -> Double {
        let inDegrees = Double(toConvert) ?? 0
        switch inSelection{
            case 0:
                return inDegrees - 273.15
            case 1:
                return inDegrees
            case 2:
                return ((inDegrees + 459.67) * 5 / 9)

            default:
                return 0
        }
    }
    
    func toCelsius(toConvert: Double) -> Double {
        return toConvert + 273.15
    }
    
    func toFarenheit(toConvert: Double) -> Double {
        return ((toConvert * 9 / 5) - 459.67)
        
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Select Unit type & specify amount to convert")){
                    Picker("Units:", selection: $inSelection)
                    {
                        ForEach(0 ..< units.count){
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Enter Amount To Convert", text: $toConvert)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select Unit Type To Convert To:")){
                    Picker("Units:", selection: $outSelection)
                    {
                        ForEach(0 ..< units.count){
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Conversion:")){
                    Text("\(toConvert)° in \(units[inSelection]) is equivalent to \(converted, specifier: "%.2f")° in \(units[outSelection])")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
