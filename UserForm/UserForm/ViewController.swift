//
//  ViewController.swift
//  UserForm
//
//  Created by cloud-wise on 08/12/2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, UITextFieldDelegate{

    var responseMessage: [String: Any] = [:] //response data from the http request
    var isConverted: Bool! //Boolean variable to switch between the KM/L and MPG
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var fuelError: UILabel!
    @IBOutlet weak var vehicleError: UILabel!
    @IBOutlet weak var phoneError: UILabel!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var passError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var txtFuelConsumption: UITextField!
    @IBOutlet weak var txtVehicleNumber: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        
        getSavedData()
        
        super.viewDidLoad()
                
    }
    
    
    // ----Event Listeners for the text fields----
    
    // Email text field
    @IBAction func emailChanged(_ sender: Any)
    {
        // Locally saving the input
        UDM.shared.defaults.setValue(txtEmail.text, forKey: "email")
        
        // Checks if the input is valid
        checkEmailError()
        
        // Making sure the form is valid
        isValidForm()
    }
    
    // Password text field
    @IBAction func passChanged(_ sender: Any)
    {
        // Locally saving the input
        UDM.shared.defaults.setValue(txtPassword.text, forKey: "password")
        
        // Checks if the input is valid
        checkPasswordError()

        // Making sure the form is valid
        isValidForm()
    }
    
    // Name text field
    @IBAction func nameChanged(_ sender: Any)
    {
        // Locally saving the input
        UDM.shared.defaults.setValue(txtName.text, forKey: "name")
        
        // Checks if the input is valid
        checkNameError()
        
        // Making sure the form is valid
        isValidForm()
    }
    
    // Phone text field
    @IBAction func phoneChanged(_ sender: Any)
    {
        // Locally saving the input
        UDM.shared.defaults.setValue(txtPhone.text, forKey: "phone")
        
        // Checks if the input is valid
        checkPhoneError()
        
        // Making sure the form is valid
        isValidForm()
    }
    
    // Vehicle text field
    @IBAction func vehicleChanged(_ sender: Any)
    {
        // Locally saving the input
        UDM.shared.defaults.setValue(txtVehicleNumber.text, forKey: "vehicle")

        // Checks if the input is valid
        checkVehicleError()
        
        // Making sure the form is valid
        isValidForm()
    }

    // Fuel text field
    @IBAction func fuelChanged(_ sender: Any)
    {
        // Locally saving the input
        UDM.shared.defaults.setValue(txtFuelConsumption.text, forKey: "fuel")
        
        // Checks if the input is valid
        checkFuelError()

        // Making sure the form is valid
        isValidForm()
    }

    
    // ----Validation input functions----
    
    private func checkEmailError()
    {
        // Checks if the Email text field is empty
        if txtEmail.text == ""
        {
            emailError.text = "Required"
            emailError.isHidden = false
            isValidForm()
            return
        }
        
        if let email = txtEmail.text
        {
            // Checks if the Email text field is valid
            if let errorMessage = invalidEmail(email)
            {
                emailError.text = errorMessage
                emailError.isHidden = false
            }
            else
            {
                emailError.isHidden = true
            }
        }
    }
    
    // Regex for Email
    private func invalidEmail(_ value: String) -> String?
    {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Email Address"
        }
        return nil
    }
    
    private func checkPasswordError()
    {
        // Checks if the Password text field is empty
        if txtPassword.text == ""
        {
            passError.text = "Required"
            passError.isHidden = false
            isValidForm()
            return
        }
        
        if let password = txtPassword.text
        {
            // Checks if the Password text field is valid
            if let errorMessage = invalidPassword(password)
            {
                passError.text = errorMessage
                passError.isHidden = false
            }
            else
            {
                passError.isHidden = true
            }
        }
    }
    
    
    private func invalidPassword(_ value: String) -> String?
    {
        // Checks password length
        if value.count < 8
        {
            return "Password must contain at least 8 characters"
        }
        // Checks if the password contains at least 1 digit and if valid or not
        if containDigits(value)
        {
            return "Password must contain at least 1 digit"
        }
        return nil
    }
    
    // Regex for Password
    private func containDigits(_ value: String) -> Bool
    {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func checkNameError()
    {
        // Checks if the Full Name text field is empty
        if txtName.text == ""
        {
            nameError.text = "Required"
            nameError.isHidden = false
            isValidForm()
            return
        }
        
        if let name = txtName.text
        {
            // Checks if the Full Name text field is valid
            if let errorMessage = invalidName(name)
            {
                nameError.text = errorMessage
                nameError.isHidden = false
            }
            else
            {
                nameError.isHidden = true
            }
        }
    }
    
    // Regex for Name
    private func invalidName(_ value: String) -> String?
    {
        let regularExpression = "^[a-zA-Z]{2,}( {1,2}[a-zA-Z]{2,}){1,2}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Full Name must contain at least 2 letters in each word"
        }
        return nil
    }
    

    private func checkPhoneError()
    {
        // Checks if the Phone text field is empty
        if txtPhone.text == ""
        {
            phoneError.text = ""
            phoneError.isHidden = true
            isValidForm()
            return
        }
        
        if let phoneNumber = txtPhone.text
        {
            // Checks if the Phone text field is valid
            if let errorMessage = invalidPhoneNumber(phoneNumber)
            {
                phoneError.text = errorMessage
                phoneError.isHidden = false
            }
            else
            {
                phoneError.isHidden = true
            }
        }

    }
    
    // Regex for Phone number
    private func invalidPhoneNumber(_ value: String) -> String?
    {
        let set = CharacterSet(charactersIn: value)
        
        if !CharacterSet.decimalDigits.isSuperset(of: set)
        {
            return "Phone Number must contain only digits"
        }
        
        if value.count != 10
        {
            return "Phone Number must be 10 digits in Length"
        }
        return nil
    }
    
    private func checkVehicleError()
    {
        // Checks if the Vehicle text field is empty
        if txtVehicleNumber.text == ""
        {
            vehicleError.text = "Required"
            vehicleError.isHidden = false
            isValidForm()
            return
        }
        
        if let vehicle = txtVehicleNumber.text
        {
            // Checks if the Vehicle text field is valid
            if let errorMessage = invalidVehicleNumber(vehicle)
            {
                vehicleError.text = errorMessage
                vehicleError.isHidden = false
            }
            else
            {
                vehicleError.isHidden = true
            }
        }
    }
    
    // Regex for Vehicle number - Format is: XXX-XX-XXX
    private func invalidVehicleNumber(_ value: String) -> String?
    {
        let regularExpression = "^[0-9]{3,3}[-][0-9]{2,2}[-][0-9]{3,3}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Vehicle Number, use numbers only: 'XXX-XX-XXX'"
        }
        return nil
    }
    
    private func checkFuelError(){
        
        // Checks if the Fuel Consumption text field is empty
        if txtFuelConsumption.text == ""
        {
            fuelError.text = "Required"
            fuelError.isHidden = false
            isValidForm()
            return
        }
        
        if let fuel = txtFuelConsumption.text
        {
            // Checks if the Fuel Consumption text field is valid
            if let errorMessage = invalidFuel(fuel)
            {
                fuelError.text = errorMessage
                fuelError.isHidden = false
            }
            else
            {
                fuelError.isHidden = true
            }
        }
    }
    
    // Regex for Fuel
    private func invalidFuel(_ value: String) -> String?
    {
        let regularExpression = "^[+]?[0-9]*(\\.[0-9]+)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Fuel must contain only digits"
        }
        return nil
    }
    
    // Resets the form
    private func resetForm()
    {
        // Resetting the buttons
        submitBtn.isEnabled = false
        isConverted = false
        convertButton.setTitle("Convert to MPG", for: .normal)
        
        
        // Resetting the text errors appearance
        emailError.isHidden = false
        passError.isHidden = false
        nameError.isHidden = false
        phoneError.isHidden = true
        vehicleError.isHidden = false
        fuelError.isHidden = false
        
        // Resetting the text fields
        txtEmail.text = ""
        txtPassword.text = ""
        txtName.text = ""
        txtPhone.text = ""
        txtVehicleNumber.text = ""
        txtFuelConsumption.text = ""
        
        // Resetting the text errors
        emailError.text = "Required"
        passError.text = "Required"
        nameError.text = "Required"
        phoneError.text = ""
        vehicleError.text = "Required"
        fuelError.text = "Required"
        
        // Locally saving the data
        UDM.shared.defaults.setValue(txtEmail.text, forKey: "email")
        UDM.shared.defaults.setValue(txtPassword.text, forKey: "password")
        UDM.shared.defaults.setValue(txtName.text, forKey: "name")
        UDM.shared.defaults.setValue(txtPhone.text, forKey: "phone")
        UDM.shared.defaults.setValue(txtVehicleNumber.text, forKey: "vehicle")
        UDM.shared.defaults.setValue(txtFuelConsumption.text, forKey: "fuel")

    }
    
    // Validate the form
    private func isValidForm()
    {
        // Checks if there are no input errors
        if emailError.isHidden && passError.isHidden && nameError.isHidden && phoneError.isHidden && vehicleError.isHidden && fuelError.isHidden
        {
            submitBtn.isEnabled = true
        }
        else
        {
            submitBtn.isEnabled = false
        }
    }
    
    // Getting the saved data
    private func getSavedData()
    {
        // Locally retrieves the data
        txtEmail.text = UDM.shared.getEmail()
        txtPassword.text = UDM.shared.getPassword()
        txtName.text = UDM.shared.getName()
        txtPhone.text = UDM.shared.getPhone()
        txtVehicleNumber.text = UDM.shared.getVehicle()
        txtFuelConsumption.text = UDM.shared.getFuel()
        isConverted = UDM.shared.getConvertState()
        
        // Making sure to check for input errors
        checkEmailError()
        checkPasswordError()
        checkNameError()
        checkPhoneError()
        checkVehicleError()
        checkFuelError()
        
        // Validates the form
        isValidForm()
    }
    
    // Sends the data to the second view
    private func SendDataToSecondView()
    {
        if (!responseMessage.isEmpty)
        {
            // Sending the data to the second view controller and present it
            let vc = storyboard?.instantiateViewController(withIdentifier: "info_vc") as! SecondViewController
            vc.infoText = responseMessage
            present(vc,animated: true)
        }
    }
    
    // -- Event Listners for the buttons click --
    
    // Submit form button
    @IBAction func submitForm(_ sender: UIButton)
    {

        // HTTP Request
        postRequest()
        
        // Making sure the request has enough time to send and receive the data
        usleep(1300000)
        
        SendDataToSecondView()

    }

    
    // Clear form button
    @IBAction func clearBtn(_ sender: UIButton) {
        resetForm()
    }
    
    // Button that converts the fuel from KM/L to MPG and vice versa
    @IBAction func convertBtn(_ sender: UIButton)
    {
        // Locally getting the Fuel number
        txtFuelConsumption.text = UDM.shared.getFuel()
        
        // Locally getting the Converted state ( true or false )
        isConverted = UDM.shared.getConvertState()
        
        let fuel = txtFuelConsumption.text
        
        // Making sure the Fuel number is not empty and if its valid
        if fuel != "" && invalidFuel(fuel!) == nil
        {
            // Parsing the Fuel number from string to Float
            let fuel_float = Float(fuel ?? "0")

            if !isConverted
            {
                // Converting the Fuel number from KM/L to MPG
                txtFuelConsumption.text = String(format: "%.2f",2.3521458*fuel_float!)
                
                // Changing the button's text
                convertButton.setTitle("Convert to Km/l", for: .normal)
                
                // Locally saving the Fuel number and the button's state
                UDM.shared.defaults.setValue(txtFuelConsumption.text, forKey: "fuel")

                isConverted = true
                
                UDM.shared.defaults.setValue(isConverted, forKey: "convert")
            }
            else
            {
                // Converting the Fuel number from MPG to KM/L
                txtFuelConsumption.text = String(format: "%.2f",fuel_float!/2.3521458)
                
                // Changing the button's text
                convertButton.setTitle("Convert to MPG", for: .normal)
                
                // Locally saving the Fuel number and the button's state
                UDM.shared.defaults.setValue(txtFuelConsumption.text, forKey: "fuel")
                
                isConverted = false
                
                UDM.shared.defaults.setValue(isConverted, forKey: "convert")
            }
        }
    }
    
    // HTTP Request function - sending the input parameters to the server
    private func postRequest()
    {
        // Making sure to send the Fuel number as a KM/L to the server
        if (UDM.shared.getConvertState())
        {
            let fuel = txtFuelConsumption.text
            let fuel_float = Float(fuel ?? "0")

            if isConverted
            {
                txtFuelConsumption.text = String(format: "%.2f",fuel_float!/2.3521458)
                convertButton.setTitle("Convert to MPG", for: .normal)
                
                UDM.shared.defaults.setValue(txtFuelConsumption.text, forKey: "fuel")
                
                isConverted = false
                
                UDM.shared.defaults.setValue(isConverted, forKey: "convert")
            }
        }
      // Set up the paramters
      let parameters: [String: Any] = ["FuelConsumption": txtFuelConsumption.text!, "Email": txtEmail.text!, "Password": txtPassword.text!, "Phone": txtPhone.text!, "FullName": txtName.text!, "VehicleNumber": txtVehicleNumber.text!]
      
      // Create the url with URL
      let url = URL(string: "https://www.cloud-wise.net/CloudApps/Server/api/log")!
      
      // Create the session object
      let session = URLSession.shared
      
      // Now create the URLRequest object using the url object
      var request = URLRequest(url: url)
      request.httpMethod = "POST" //set http method as POST
      
      // Add headers for the request
      request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
      request.addValue("application/json", forHTTPHeaderField: "Accept")
      
      do {
        // Convert parameters to Data and assign dictionary to httpBody of request
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
      } catch let error {
        print(error.localizedDescription)
      }
      
      // Create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { [self] data, response, error in
        
        if let error = error {
          print("Post Request Error: \(error.localizedDescription)")
          return
        }
        
        // Ensure there is valid response code returned from this HTTP response
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
          print("Invalid Response received from the server")
          return
        }
        
        // Ensure there is data returned
        guard let responseData = data else {
          print("nil Data received from the server")
          return
        }
        
        do {
          // Create json object from data or use JSONDecoder to convert to Model stuct
          if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any]
            {
              // Checks if the response message is "Success"
              if jsonResponse["Message"] as! String == "Success"{
                  responseMessage = jsonResponse
              }
              
            // handle json response
          } else {
            print("data maybe corrupted or in wrong format")
            throw URLError(.badServerResponse)
          }
        } catch let error {
          print(error.localizedDescription)
        }
      }
      // perform the task
      task.resume()
    }
    
}


// A Class made for saving the data
class UDM {
    
    static let shared = UDM()
    
    let defaults = UserDefaults(suiteName: "saved.data")!
    
    // Saves the Email
    func getEmail()->String{
        if let value = defaults.value(forKey: "email")
        {
            return value as! String
        }
        return ""
    }
    
    // Saves the Password
    func getPassword()->String{
        if let value = defaults.value(forKey: "password")
        {
            return value as! String
        }
        return ""
    }
    
    // Saves the Full Name
    func getName()->String{
        if let value = defaults.value(forKey: "name")
        {
            return value as! String
        }
        return ""
    }
    
    // Saves the Phone Number
    func getPhone()->String{
        if let value = defaults.value(forKey: "phone")
        {
            return value as! String
        }
        return ""
    }
    
    // Saves the Vehicle Number
    func getVehicle()->String{
        if let value = defaults.value(forKey: "vehicle")
        {
            return value as! String
        }
        return ""
    }
    
    // Saves the Fuel Number
    func getFuel()->String{
        if let value = defaults.value(forKey: "fuel")
        {
            return value as! String
        }
        return ""
    }
    
    // Saves the button's converted state
    func getConvertState()->Bool{
        if let value = defaults.value(forKey: "convert")
        {
            return value as! Bool
        }
        return false
    }
}
