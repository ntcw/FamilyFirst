//
//  AddMemberSubviewController.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 20.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//
import CoreData
import UIKit

protocol AddMemberSubviewControllerDelegate {
    func getName(name: String?)
    func getImage(image: UIImage?)
    func getBirthdate(date: Date?)
    func getHealthCare(healthCare: Int32?)
    func getBloodType(bloodType: String?)
    func getAllergy(allergy: String?)
    func getVaccination(vaccination: String?)
    func getPhoneNr(phoneNr: Int32?)
    func getEmail(email: String?)
    func getStreet(street: String?)
    func getPostalCode(postalCode: Int16?)
    func getCity(city: String?)
    func getAdditionalTitle(additionalTitle: [String]?)
    func getAdditionalDetail(additionalDetail: [String]?)
}

class AddMemberSubviewController: UITableViewController, UITextViewDelegate{
    
    
    var actualView: UIView?
    @IBOutlet var addStuffPopover: UIView!
    @IBOutlet weak var detailsAddStuff: UILabel!
    @IBOutlet weak var titleAddStuff: UILabel!
    
    @IBOutlet var vaccinationView: UIView!
    @IBOutlet weak var vaccinationTextview: UITextView!
    @IBOutlet weak var allergiesField: UITextView!
    @IBOutlet var allergiesPopover: UIView!
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    let blackView = UIView()
    var datePickerHidden = true
    var imagePicker: UIImagePickerController!
    var addStuff: [Additional] = []
    var additional: [String] = []
    var additionalTitle: [String] = []
    
    var titles = ["","Medical Information", "Contact Informations", "Additional Stuff"]
    var section1Hidden = true
    var section2Hidden = true
    var section3Hidden = true
    
    var delegate: AddMemberSubviewControllerDelegate?

    var newPhoto: UIImage? {
        didSet{
            memberPhoto.image = self.newPhoto
            if let delegate = delegate{
                delegate.getImage(image: self.newPhoto)
            }
            PictureLabel.text = ""
        }
    }
    
    
    
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
   
   
    @IBOutlet weak var PictureLabel: UILabel!
    @IBOutlet weak var memberPhoto: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
        
        PictureLabel.font = UIFont(name: "KohinoorTelugu-Medium", size: 50)
        PictureLabel.textColor = .white
        
        if let delegate = delegate{
            delegate.getBirthdate(date: datePickerOutlet.date)
        }
        
        
        setTextView(textView: allergiesField, placeHolder: "Enter Allergy")
        setTextView(textView: vaccinationTextview, placeHolder: "Enter Vaccination")
        
        
        
    }
    
    func setTextView(textView: UITextView, placeHolder: String){
        textView.text = placeHolder
        textView.textColor = UIColor.darkGray
//        TextView.font = UIFont(name: "KohinoorTelugu-Medium", size: 14)
        textView.delegate = self
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.backgroundColor = UIColor(displayP3Red: 194, green: 201, blue: 204, alpha: 0.3).cgColor

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        memberPhoto.isUserInteractionEnabled = true
        memberPhoto.addGestureRecognizer(tapGestureRecognizer)
        tableView.register(AdditionalTableCell.self, forCellReuseIdentifier: "addCell")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destController = segue.destination as? AddStuffController else {
            return
        }
        destController.onDoneButton = {(title, detail) in
            self.additionalTitle.append(title)
            self.additional.append(detail)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func nameField(_ sender: UITextField) {
        if let delegate = delegate {
            delegate.getName(name: sender.text)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.darkGray {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "KohinoorTelugu-Medium", size: 14)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView.restorationIdentifier == "vaccinationView"{
                textView.text = "Insert Vaccination"
            }else {
                textView.text = "Insert Allergy"
            }
            textView.textColor = UIColor.darkGray
            textView.font = UIFont(name: "KohinoorTelugu-Medium", size: 14)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        button.setTitle(titles[section], for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        
        button.addTarget(self, action: #selector(handleExpandClose(section:)), for: .touchUpInside)
        
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        headerview.addSubview(button)
        return button
    }
    
    @objc func handleExpandClose(section: UIButton){
        let title = section.titleLabel?.text ?? ""
        
        switch title {
        case "Medical Information":
            if section1Hidden {
                opensection(attribute: false, section: title)
            }else {
                opensection(attribute: true, section: title)
            }
        case "Contact Informations":
            if section2Hidden {
                opensection(attribute: false, section: title)
            }else {
                opensection(attribute: true, section: title)
            }
        case "Additional Stuff":
            if section3Hidden {
                opensection(attribute: false, section: title)
            }else {
                opensection(attribute: true, section: title)
            }
        default:
            break
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = titles[indexPath.section]
        if section1Hidden && section == "Medical Information" {
            return 0.0
        }else if !section1Hidden && section == "Medical Information" {
            return 44
        }else if section2Hidden && section == "Contact Informations" {
            return 0.0
        }else if !section2Hidden && section == "Contact Informations" {
            return 44
        }
         else if section3Hidden && section == "Additional Stuff" {
            return 0.0
        }else if !section3Hidden && section == "Additional Stuff" {
            return 44
        }
        else if indexPath.section == 0 && indexPath.row == 0{
            return 175
        }
        else if datePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 0
        }else if !datePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 190
        }
        return 44
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 && datePickerHidden{
            setDate(pickerHidden: false)
        }else if indexPath.section == 0 && indexPath.row == 1 && !datePickerHidden{
            setDate(pickerHidden: true)
        }else if indexPath.section == 1 && indexPath.row == 2 {
            getPopover(popOver: allergiesPopover)
        }else if indexPath.section == 1 && indexPath.row == 3 {
            getPopover(popOver: vaccinationView)
        }else if indexPath.section == 3 {
            getPopover(popOver: addStuffPopover)
            titleAddStuff.text = additionalTitle[indexPath.row]
            detailsAddStuff.text = additional[indexPath.row]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell") as! AdditionalTableCell

            cell.textLabel?.text = additionalTitle[indexPath.row]
            //cell.textLabel?.text = "Hello"
            return cell
            
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return additional.count
            //the datasource of the dynamic section
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 3 {
            let newIndexPath = IndexPath(row: 5, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        }
        return super.tableView(tableView, indentationLevelForRowAt: indexPath as IndexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            datePickerHidden = true
            tableView.reloadData()
        }
    }
    
    
    func getPopover(popOver: UIView){
        if let window = UIApplication.shared.keyWindow{
            getBlackBackground(secondView: popOver)
            window.addSubview(popOver)
            popOver.backgroundColor = .white
            popOver.center = view.center
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
            }, completion: nil)
            
        }
    }
    
    func getBlackBackground(secondView: UIView) {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            actualView = secondView
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
        actualView?.removeFromSuperview()
    }
    
    
    
    func setDate(pickerHidden: Bool){
        datePickerHidden = pickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        dateLabel.text = dateFormatter.string(from: sender.date)
        if let delegate = delegate{
            delegate.getBirthdate(date: sender.date)
        }
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
    
        tappedImage.image = getImage()
        //PictureLabel.text = ""
        tableView.reloadData()
        
        
    }
    
    
    @IBAction func AddButton(_ sender: UIButton) {
    }
    
    func opensection(attribute: Bool,section: String) {
        switch section {
        case "":
            break
        case "Medical Information":
            section1Hidden = attribute
        case "Contact Informations":
            section2Hidden = attribute
        default:
            section3Hidden = attribute
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func addAllergy(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
        allergiesPopover.removeFromSuperview()
    }
    @IBAction func addVaccination(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
        }
        vaccinationView.removeFromSuperview()
    }
    
    func addToArray(addtional: String) {
        additional.append(addtional)
        tableView.reloadData()
    }
    
   
    
}





