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

class AddMemberSubviewController: UITableViewController, UITextViewDelegate {
    var selectedMember: FamilyMember?

    var initialLaunch = true
    var shouldhide = false
    var actualView: UIView?
    @IBOutlet var addStuffPopover: UIView!
    @IBOutlet var detailsAddStuff: UILabel!
    @IBOutlet var titleAddStuff: UILabel!

    @IBOutlet var vaccinationView: UIView!
    @IBOutlet var vaccinationTextview: UITextView!
    @IBOutlet var allergiesField: UITextView!
    @IBOutlet var allergiesPopover: UIView!
    @IBOutlet var datePickerOutlet: UIDatePicker!

    @IBOutlet var nameTextfield: UITextField!
    @IBOutlet var healthCareTextfield: UITextField!
    @IBOutlet var bloodTypeTextfield: UITextField!
    @IBOutlet var phoneTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var postalTextfield: UITextField!
    @IBOutlet var streetTextfield: UITextField!
    @IBOutlet var cityTextfield: UITextField!

    @IBOutlet var healthCare: UILabel!
    @IBOutlet var bloodType: UILabel!
    @IBOutlet var phoneNr: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var street: UILabel!
    @IBOutlet var postalCode: UILabel!
    @IBOutlet var city: UILabel!
    @IBOutlet var addAdditionalLabel: UILabel!
    @IBOutlet var dateOutlet: UIDatePicker!
    @IBOutlet var dateDetail: UILabel!

    var allergy: String?
    var vaccination: String?
    let blackView = UIView()
    var datePickerHidden = true
    var imagePicker: UIImagePickerController!
    var additional: [String] = []
    var additionalTitle: [String] = []
    public static var triggeredReload = false
    let greyBackgroundColor = UIColor(displayP3Red: 194, green: 201, blue: 204, alpha: 0.3)

    var titles = ["", "Medical Information", "Contact Information", "Additional Information"]
    var section1Hidden = true
    var section2Hidden = true
    var section3Hidden = true

    var delegate: AddMemberSubviewControllerDelegate?

    var newPhoto: UIImage? {
        didSet {
            memberPhoto.image = newPhoto
            if let delegate = delegate {
                delegate.getImage(image: newPhoto)
            }
            PictureLabel.text = ""
        }
    }

    enum ImageSource {
        case photoLibrary
        case camera
    }

    @IBOutlet var PictureLabel: UILabel!
    @IBOutlet var memberPhoto: UIImageView!

    @IBOutlet var dateLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if initialLaunch{
            setTextView(textView: allergiesField, placeHolder: "Enter Allergy")
            setTextView(textView: vaccinationTextview, placeHolder: "Enter Vaccination")
        }
        
        fillWithData()
        

        view.backgroundColor = .clear

        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self

        PictureLabel.font = UIFont(name: "KohinoorTelugu-Medium", size: 50)
        PictureLabel.textColor = .white

        
        if let delegate = delegate {
            delegate.getBirthdate(date: datePickerOutlet.date)
        }

        healthCare.textColor = .white
        bloodType.textColor = .white
        phoneNr.textColor = .white
        email.textColor = .white
        street.textColor = .white
        postalCode.textColor = .white
        city.textColor = .white
        addAdditionalLabel.textColor = .white
        nameTextfield.backgroundColor = greyBackgroundColor
        healthCareTextfield.backgroundColor = greyBackgroundColor
        bloodTypeTextfield.backgroundColor = greyBackgroundColor
        allergiesField.backgroundColor = greyBackgroundColor
        vaccinationTextview.backgroundColor = greyBackgroundColor
        phoneTextfield.backgroundColor = greyBackgroundColor
        emailTextfield.backgroundColor = greyBackgroundColor
        streetTextfield.backgroundColor = greyBackgroundColor
        postalTextfield.backgroundColor = greyBackgroundColor
        cityTextfield.backgroundColor = greyBackgroundColor
    }

    func fillWithData() {
        if let editMember = selectedMember, initialLaunch {
            nameTextfield.text = editMember.name
            if let picture = editMember.picture {
                memberPhoto.image = UIImage(data: picture)
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MMMM/yyyy"
            dateLabel.text = dateFormatter.string(from: editMember.birthday ?? Date())
            healthCareTextfield.text = "\(editMember.healthCare)"
            bloodTypeTextfield.text = editMember.bloodtype
            allergy = editMember.allergies
            vaccination = editMember.vaccinations
            phoneTextfield.text = "\(editMember.phoneNr)"
            emailTextfield.text = editMember.email
            streetTextfield.text = editMember.street
            postalTextfield.text = "\(editMember.zipcode)"
            cityTextfield.text = editMember.city
            additionalTitle = editMember.additionalTitle ?? []
            additional = editMember.additional ?? []
            shouldhide = true
        }
    }

    func setTextView(textView: UITextView, placeHolder: String) {
        textView.text = placeHolder
        textView.textColor = UIColor.darkGray
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
        destController.onDoneButton = { title, detail in
            self.additionalTitle.append(title)
            self.additional.append(detail)
            self.section3Hidden = false
            if let delegate = self.delegate {
                delegate.getAdditionalTitle(additionalTitle: self.additionalTitle)
                delegate.getAdditionalDetail(additionalDetail: self.additional)
            }
            self.tableView.reloadData()
        }
        destController.onCancelButton = {
            self.shouldhide = true
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
            if textView.restorationIdentifier == "vaccinationView" {
                textView.text = "Insert Vaccination"
            } else {
                textView.text = "Insert Allergy"
            }
            textView.textColor = UIColor.darkGray
            textView.font = UIFont(name: "KohinoorTelugu-Medium", size: 14)
        } else {
            if let delegate = delegate {
                if textView.restorationIdentifier == "vaccinationTextView" {
                    delegate.getVaccination(vaccination: textView.text)
                } else {
                    delegate.getAllergy(allergy: textView.text)
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "KohinoorTelugu-Bold", size: 20)
        button.titleLabel?.font = button.titleLabel?.font.bold()
        button.setTitle(titles[section], for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.darkGray, for: .selected)
        button.backgroundColor = UIColor(displayP3Red: 194, green: 201, blue: 204, alpha: 0.1)

        button.addTarget(self, action: #selector(handleExpandClose(section:)), for: .touchUpInside)

        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
        headerview.addSubview(button)
        return button
    }

    @objc func handleExpandClose(section: UIButton) {
        let title = section.titleLabel?.text ?? ""

        switch title {
        case "Medical Information":
            if section1Hidden {
                opensection(attribute: false, section: title)
            } else {
                opensection(attribute: true, section: title)
            }
        case "Contact Information":
            if section2Hidden {
                opensection(attribute: false, section: title)
            } else {
                opensection(attribute: true, section: title)
            }
        case "Additional Information":
            if section3Hidden {
                opensection(attribute: false, section: title)
                if additionalTitle.count != 0 {
                    let bottom = IndexPath(row: additionalTitle.count - 1, section: 3)
                    scrollToBottom(indexPath: bottom)
                }
            } else {
                opensection(attribute: true, section: title)
            }
        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }

        return 50
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = titles[indexPath.section]
        if section1Hidden && section == "Medical Information" {
            return 0.0
        } else if !section1Hidden && section == "Medical Information" {
            return 44
        } else if section2Hidden && section == "Contact Information" {
            return 0.0
        } else if !section2Hidden && section == "Contact Information" {
            return 44
        } else if section3Hidden && section == "Additional Information" {
            if let cell = tableView.cellForRow(at: indexPath) as? AdditionalTableCell {
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionFlipFromTop, animations: {
                    cell.titleLabel.alpha = 0
                }, completion: nil)
            }
            return 0.0
        } else if !section3Hidden && section == "Additional Information" {
            if let cell = tableView.cellForRow(at: indexPath) as? AdditionalTableCell {
                if cell.titleLabel.isHidden {
                    cell.titleLabel.isHidden = false
                }
                UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionFlipFromTop, animations: {
                    cell.titleLabel.alpha = 1
                }, completion: nil)
            }
            return 60
        } else if indexPath.section == 0 && indexPath.row == 0 {
            return 175
        } else if datePickerHidden && indexPath.section == 0 && indexPath.row == 2 {
            return 0
        } else if !datePickerHidden && indexPath.section == 0 && indexPath.row == 2 {
            return 190
        }
        return 44
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && shouldhide {
            if let cell = cell as? AdditionalTableCell {
                cell.titleLabel.isHidden = true
                if indexPath.row == additionalTitle.count - 1 {
                    shouldhide = false
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 && datePickerHidden {
            setDate(pickerHidden: false)
        } else if indexPath.section == 0 && indexPath.row == 1 && !datePickerHidden {
            setDate(pickerHidden: true)
        } else if indexPath.section == 1 && indexPath.row == 2 {
            getPopover(popOver: allergiesPopover)
        } else if indexPath.section == 1 && indexPath.row == 3 {
            getPopover(popOver: vaccinationView)
        } else if indexPath.section == 3 {
            getPopover(popOver: addStuffPopover)
            titleAddStuff.text = additionalTitle[indexPath.row]
            detailsAddStuff.text = additional[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addCell") as! AdditionalTableCell
            cell.additional = additionalTitle[indexPath.row]

            cell.titleLabel.alpha = 1
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return additional.count
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if editingStyle == .delete {
                additionalTitle.remove(at: indexPath.row)
                additional.remove(at: indexPath.row)
                if let delegate = delegate {
                    delegate.getAdditionalTitle(additionalTitle: additionalTitle)
                    delegate.getAdditionalDetail(additionalDetail: additional)
                }
                tableView.reloadData()
            }
        }
    }

    func getPopover(popOver: UIView) {
        if let window = UIApplication.shared.keyWindow {
            getBlackBackground(secondView: popOver)
            window.addSubview(popOver)
            popOver.backgroundColor = .white
            popOver.center = view.center
            popOver.layer.cornerRadius = 45

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

    func setDate(pickerHidden: Bool) {
        datePickerHidden = pickerHidden

        tableView.beginUpdates()
        tableView.endUpdates()
    }

    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        dateLabel.text = dateFormatter.string(from: sender.date)
        if let delegate = delegate {
            delegate.getBirthdate(date: sender.date)
        }
    }

    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        tappedImage.image = getImage()
        tableView.reloadData()
    }

    @IBAction func AddButton(_ sender: UIButton) {
    }

    func opensection(attribute: Bool, section: String) {
        switch section {
        case "":
            break
        case "Medical Information":
            section1Hidden = attribute
        case "Contact Information":
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

    func scrollToBottom(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    @IBAction func healthcareFunction(_ sender: UITextField) {
        if let delegate = delegate {
            if let number = Int(sender.text ?? "0") {
                delegate.getHealthCare(healthCare: Int32(number))
            }
        }
    }

    @IBAction func bloodTypeFunction(_ sender: UITextField) {
        if let delegate = delegate {
            delegate.getBloodType(bloodType: sender.text)
        }
    }

    @IBAction func phoneFunction(_ sender: UITextField) {
        if let delegate = delegate {
            let number = Int(sender.text ?? "0")
            delegate.getPhoneNr(phoneNr: Int32(number ?? 0))
        }
    }

    @IBAction func emailFunc(_ sender: UITextField) {
        if let delegate = delegate {
            delegate.getEmail(email: sender.text)
        }
    }

    @IBAction func streetFunc(_ sender: UITextField) {
        if let delegate = delegate {
            delegate.getStreet(street: sender.text)
        }
    }

    @IBAction func postalFunc(_ sender: UITextField) {
        if let delegate = delegate {
            let number = Int(sender.text ?? "0")
            delegate.getPostalCode(postalCode: Int16(number ?? 0))
        }
    }

    @IBAction func cityFunction(_ sender: UITextField) {
        if let delegate = delegate {
            delegate.getCity(city: sender.text)
        }
    }
}
