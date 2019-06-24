//
//  AddMemberSubviewController.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 20.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//
import CoreData
import UIKit

class AddMemberSubviewController: UITableViewController{
    
    var datePickerHidden = true
    var imagePicker: UIImagePickerController!
    var addStuff: [Additional] = []

    var newPhoto: UIImage? {
        didSet{
            memberPhoto.image = self.newPhoto
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
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        memberPhoto.isUserInteractionEnabled = true
        memberPhoto.addGestureRecognizer(tapGestureRecognizer)
        
        tableView.register(UINib(nibName: "AdditionalCell", bundle: nil), forCellReuseIdentifier: "AdditionalCell")
        
//        if let imgview = memberPhoto.image {
//            PictureLabel.isEnabled = false
//        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return 175
        }
        else if datePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 0
        }else if !datePickerHidden && indexPath.section == 0 && indexPath.row == 2{
            return 190
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 && datePickerHidden{
            setDate(pickerHidden: false)
        }else if indexPath.section == 0 && indexPath.row == 1 && !datePickerHidden{
            setDate(pickerHidden: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalCell") as! AdditionalCell
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return self.addStuff.count
            //the datasource of the dynamic section
        }
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        if indexPath.section == 3 {
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
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
    
    func setDate(pickerHidden: Bool){
        datePickerHidden = pickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMMM/yyyy"
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
    
        tappedImage.image = getImage()
        PictureLabel.text = ""
        tableView.reloadData()
        
        
    }
    
    
    @IBAction func AddButton(_ sender: UIButton) {
    }
    
}



extension AddMemberSubviewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
        func getImage() -> UIImage?{
            var newImage: UIImage?
            choosePhotoMode()
            if let newPhoto = newPhoto {
                newImage = newPhoto
                self.newPhoto = nil
            }
            return newImage
        }
    
        func choosePhotoMode(){
            let optionMenu = UIAlertController(title: nil, message: "Choose a Image", preferredStyle: .actionSheet)
            let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default, handler: {(_: UIAlertAction!)-> Void in self.photoLibrary()})
            
            let takePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: {(_: UIAlertAction!)-> Void in self.camera()})
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            optionMenu.addAction(choosePhoto)
            optionMenu.addAction(takePhoto)
            optionMenu.addAction(cancelAction)
            
            present(optionMenu, animated: true, completion: nil)
    }
        
        func camera(){
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                selectImageFrom(.photoLibrary)
                return
            }
           selectImageFrom(.camera)
        }
    
    func photoLibrary(){
        guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {
            return
        }
        selectImageFrom(.photoLibrary)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        case .camera:
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newPhoto = image
        } else {
            print("Something went wrong")
        }
        dismiss(animated: true, completion: nil)
    }
   
        
}
