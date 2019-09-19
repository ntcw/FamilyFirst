//
//  AddMemberViewController.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 20.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {
    var member: FamilyMember?
    var selectedMember: FamilyMember?
    var editMember = false

    var id: Int32?
    var name: String?
    var date: Date?
    var image: UIImage?
    var healthCare: Int64?
    var bloodType: String?
    var allergy: String?
    var vaccination: String?
    var phoneNr: Int64?
    var email: String?
    var street: String?
    var zipcode: Int16?
    var city: String?
    var additionalTitle: [String]?
    var additionalDetail: [String]?

    var subview: AddMemberSubviewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismiss()
        guard let subviewController = children.first as? AddMemberSubviewController else {
            fatalError("Check Storyboard for missing controller")
        }
        subview = subviewController
        subview?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "multi")?.draw(in: view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)
    }

    func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        if let name = name, let date = date {
            MemberClass.allMembers.save(name: name, date: date, image: image, healthCare: healthCare ?? 0, bloodtype: bloodType ?? "", allergy: allergy ?? "", vaccination: vaccination ?? "", phoneNr: phoneNr ?? 0, email: email ?? "", street: street ?? "", postalCode: zipcode ?? 0, city: city ?? "", addTitle: additionalTitle, addDetail: additionalDetail, id: id)
        }

        dismiss(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddMemberSubviewController {
            vc.selectedMember = selectedMember
        }
    }
}

extension AddMemberViewController: AddMemberSubviewControllerDelegate {
    func getVaccination(vaccination: String?) {
        self.vaccination = vaccination
    }

    func getAdditionalDetail(additionalDetail: [String]?) {
        self.additionalDetail = additionalDetail
    }

    func getHealthCare(healthCare: Int64?) {
        self.healthCare = healthCare
    }

    func getPhoneNr(phoneNr: Int64?) {
        self.phoneNr = phoneNr
    }

    func getPostalCode(postalCode: Int16?) {
        zipcode = postalCode
    }

    func getCity(city: String?) {
        self.city = city
    }

    func getAdditionalTitle(additionalTitle: [String]?) {
        self.additionalTitle = additionalTitle
    }

    func getBloodType(bloodType: String?) {
        self.bloodType = bloodType
    }

    func getAllergy(allergy: String?) {
        self.allergy = allergy
    }

    func getEmail(email: String?) {
        self.email = email
    }

    func getStreet(street: String?) {
        self.street = street
    }

    func getName(name: String?) {
        self.name = name
    }

    func getBirthdate(date: Date?) {
        self.date = date
    }

    func getImage(image: UIImage?) {
        self.image = image
    }
}
