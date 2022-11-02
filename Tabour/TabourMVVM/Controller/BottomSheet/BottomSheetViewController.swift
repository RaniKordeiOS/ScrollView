//
//  BottomSheetViewController.swift
//  Tabour
//
//  Created by Dharmesh Kothari on 20/10/22.

//https://medium.com/@kentakodashima/ios-google-places-autocomplete-api-e064c683b5a3
//https://youtu.be/BnL_kN1frWc
//https://youtu.be/oJU4RvZcxWo
//https://codewithchris.com/uipickerview-example/
//https://iostutorialjunction.com/2017/11/create-multiple-component-uipickerview-ios-swift-tutorial.html

import UIKit
import GooglePlaces

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var btnLocation: UIButton!
    
    @IBOutlet weak var btnGuestAndDate_Time: UIButton!
    
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var viewBackNumberOfGuest: UIView!
    
    @IBOutlet weak var labelGuestNumber: UILabel!
    
    
    @IBOutlet weak var omr_segment: UISegmentedControl!
    //  var pickerData: [String] = [String]()
    //var pickerData: [[String]] = [[String]]()
    var dayArray:[String] = Array()
    var timeArray:[String] = Array()
    var numberOfGuest :Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.view.backgroundColor = .lightGray
        setDataForUIPicker()
        configureViews()
        con_OMR_segment()
    }
    func con_OMR_segment()
    {
        //colorRGB(r: 77, g: 101, b: 108)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: colorRGB(r: 77, g: 101, b: 108), NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 18.0)!] as [NSAttributedString.Key : Any]
        
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        let titleTextAttributesDefault = [NSAttributedString.Key.foregroundColor: colorRGB(r: 233, g: 196, b: 106), NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 18.0)!] as [NSAttributedString.Key : Any]
        
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesDefault, for: .normal)
       // let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 16.0), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        omr_segment.backgroundColor = colorRGB(r: 2, g: 35, b: 47)
        omr_segment.selectedSegmentTintColor = colorRGB(r: 2, g: 35, b: 47)
       // omr_segment.tintColor = colorRGB(r: 2, g: 35, b: 47)
       // omr_segment.defaultConfiguration()
       // omr_segment.selectedConfiguration()
    }
    func configureViews()
    {
        labelGuestNumber.text = "\(numberOfGuest)"
        btnDone.layer.cornerRadius = btnDone.frame.width * 0.02
        labelGuestNumber.layer.cornerRadius = labelGuestNumber.frame.width * 0.06
        labelGuestNumber.layer.borderColor = colorRGB(r: 178, g: 202, b: 209).cgColor
        labelGuestNumber.layer.borderWidth = 1
        labelGuestNumber.layer.masksToBounds = true
        viewBackNumberOfGuest.backgroundColor = .clear
    }
    
    
//    @IBAction func onClickCSController(_ sender: CustomSegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            print("guest 0")
//            print(sender.selectedSegmentIndex)
//            break
//        case 1:
//            print("location 1")
//            print(sender.selectedSegmentIndex)
//            break
//        default:
//            print("hello 0")
//            print(sender.selectedSegmentIndex)
//        }
//
//
//    }
    
    @IBAction func onClickOverview(_ sender: UISegmentedControl) {
    }
    
    
    @IBAction func btnMinusGuest(_ sender: UIButton) {
        if numberOfGuest > 1
        {
            numberOfGuest = numberOfGuest - 1
            labelGuestNumber.text = "\(numberOfGuest)"
        }
    }
    
    @IBAction func btnAddGuest(_ sender: UIButton) {
        
        numberOfGuest = numberOfGuest + 1
        labelGuestNumber.text = "\(numberOfGuest)"
        
    }
    
    
    
    @IBAction func onClickGuest_DateTime(_ sender: UIButton) {
    }
    
    @IBAction func onClickLocation(_ sender: UIButton) {
    }
    
    
    @IBAction func onClickDone(_ sender: UIButton) {
        
    }
    func setDataForUIPicker()
    {/*
      pickerData = ["Today", "Tommorow", "Mon, 2 December", "Tue, 3 December", "Wed, 4 December", "Thu, 5 December", "Fri, 6 December", "Sat, 7 December"]
      
      pickerData = [["Today", "Tommorow", "Mon, 2 December", "Tue, 3 December", "Wed, 4 December", "Thu, 5 December", "Fri, 6 December", "Sat, 7 December"],
      ["10.00 AM", "10.30 AM", "11.00 AM", "11.30 AM","12.00 PM", "12.30 PM", "1.00 PM", "1.30 PM"]]
      
      */
        dayArray = ["Today", "Tommorow", "Mon, 2 December", "Tue, 3 December", "Wed, 4 December", "Thu, 5 December", "Fri, 6 December", "Sat, 7 December"]
        timeArray = ["10.00 AM", "10.30 AM", "11.00 AM", "11.30 AM","12.00 PM", "12.30 PM", "1.00 PM", "1.30 PM"]
        
    }
    
}
extension BottomSheetViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        //        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SofiaPro-SemiBold", size: 16.0), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        var pickerLabel: UILabel? = (view as? UILabel)
        if component == 0 {
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "SofiaPro-SemiBold", size: 20)
                pickerLabel?.layer.backgroundColor = UIColor.lightGray.cgColor
                //pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = dayArray[row]
            pickerLabel?.textColor = UIColor.black
        }
        else{
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "SofiaPro-SemiBold", size: 20)
                pickerLabel?.layer.backgroundColor = UIColor.lightGray.cgColor
                pickerLabel?.textAlignment = .right
            }
            pickerLabel?.text = timeArray[row]
            pickerLabel?.textColor = UIColor.black
        }
        return pickerLabel!
    }
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // return pickerData.count
        
        if component == 0 {
            return dayArray.count
        }
        return timeArray.count
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // return pickerData[row]
        //return pickerData[component][row]
        if component == 0 {
            return dayArray[row]
        }
        return timeArray[row]
    }
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        // let dateSelected = countriesArray[pickerView.selectedRow(inComponent: 0)]
        // let timeSelected = stateNumbersArray[pickerView.selectedRow(inComponent: 1)]
        
        //print(pickerView.selectedRow(inComponent: 0))
        //print(pickerView.selectedRow(inComponent: 1))
        let daySelected = dayArray[pickerView.selectedRow(inComponent: 0)]
        let timeSelected = timeArray[pickerView.selectedRow(inComponent: 1)]
        print(daySelected)
        print(timeSelected)
    }
    
}
extension UISegmentedControl
{
    func defaultConfiguration(font: UIFont = UIFont.systemFont(ofSize: 12), color: UIColor = UIColor.white)
    {
        let defaultAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }

    func selectedConfiguration(font: UIFont = UIFont.boldSystemFont(ofSize: 12), color: UIColor = UIColor.red)
    {
        let selectedAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
//MARK: Google place delegate func
extension BottomSheetViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place latitude: \(place.coordinate.latitude)")
        print("Place Longitude: \(place.coordinate.longitude)")
        print("Place name: \(String(describing: place.name))")
        print("Place ID: \(String(describing: place.placeID))")
        print("Place attributions: \(String(describing: place.addressComponents))")
        print("Place formattedAddress: \(String(describing: place.formattedAddress))")
        
        /* if check_pickeupORdrop_location == "pickup" {
         self.googlePlaces_pickup_latitude = place.coordinate.latitude
         self.googlePlaces_pickup_longitude = place.coordinate.longitude
         self.pickupPlaceName_label.text = place.formattedAddress
         self.googlePlaces_pickup_locationName = place.formattedAddress!
         } else if check_pickeupORdrop_location == "drop" {
         self.dropoffPlaceName_label.text = place.formattedAddress
         self.googlePlaces_dropoff_locationName = place.formattedAddress!
         if pickupPlaceName_label.text! == dropoffPlaceName_label.text! {
         self.dropAndPickSameLocation_button.setImage(UIImage.init(named: "checked_box"), for: .normal)
         self.is_dropAndPick_at_sameLocation = true
         } else{
         self.dropAndPickSameLocation_button.setImage(UIImage.init(named: "uncheck_box"), for: .normal)
         self.is_dropAndPick_at_sameLocation = false
         }
         }
         */
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

