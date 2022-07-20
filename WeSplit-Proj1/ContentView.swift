//
//  ContentView.swift
//  WeSplit-Proj1
//
//  Created by Saurabh Jamadagni on 15/07/22.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

//    let tipPercentageOptions = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let personCount = Double(numberOfPeople + 2)
        let tipSelected = Double(tipPercentage)
        
        let tipAmount = billAmount * (tipSelected / 100.0)
        let grandTotal = billAmount + tipAmount
        
        return grandTotal / personCount
    }
    
    var finalAmountWithTip: Double {
        return totalPerPerson * Double(numberOfPeople + 2)
    }
    
//    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
//        return .currency(code: Locale.current.currencyCode ?? "USD")
//    }
    
    let currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $billAmount, format: currencyCode)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)

                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you wish to leave?")
                }

                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(finalAmountWithTip, format: currencyCode)
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount including tip")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
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
