//
//  OptionContactTableViewController .swift
//  MySchedule
//
//  Created by Maksim  on 11.06.2022.
//

import UIKit

class OptionContactTableViewController: UITableViewController {
    
    private let idOptionsContactCell = "idOptionsContactCell"
    private let idOptionsContactCellHeader = "idOptionsContactCellHeader"
    
    private let headerNameArray = ["NAME","PHONE","MAIL","TYPE","CHOOSE IMAGE"]
    var cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    var contactModel = ContactModel()
    var imageIsChanged = false
    var editModel = false
    var dataImage: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        
        title = "Optional Contact"
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapp))
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactCellHeader)
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
   
        if editModel == false {
            cell.cellContactConfigure(nameArray: cellNameArray, index: indexPath, image: nil)
        } else if let data = contactModel.contactImage, let image = UIImage(data: data) {
            cell.cellContactConfigure(nameArray: cellNameArray, index: indexPath, image: image)
        } else {
            cell.cellContactConfigure(nameArray: cellNameArray, index: indexPath, image: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactCellHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertForCellInformation(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter name lesson") { name in
       
            self.cellNameArray[0] = name
        }
        case 1: alertForCellInformation(label: cell.nameCellLabel, name: "Phone Contact", placeholder: "Enter name lesson") { phone in
      
            self.cellNameArray[1] = phone
        }
        case 2: alertForCellInformation(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter name lesson") { mail in
      
            self.cellNameArray[2] = mail
        }
        case 3: AlertFriendOrTeacher(label: cell.nameCellLabel) { type in
     
            self.cellNameArray[3] = type
        }
        case 4: alertPhotoOrCamera { source in
            self.chooseImagePicker(source: source)
        }
        default:
            print("12345")
        }
    }
    
   private func pushControllers(vc: UIViewController, title: String) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = title
        navigationController?.pushViewController(viewController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setModel() {
        contactModel.contactName = cellNameArray[0]
        contactModel.contactPhone = cellNameArray[1]
        contactModel.contactMail = cellNameArray[2]
        contactModel.contactType = cellNameArray[3]
        contactModel.contactImage = dataImage
    }
    
    private func setImageModel() {
        
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            dataImage = imageData
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            cell.backgroundViewCell.isHidden = true
            imageIsChanged = false
        } else {
            dataImage = nil
        }
    }
    
    @objc private func saveButtonTapp() {
   
        if cellNameArray[0] == "Name" || cellNameArray[3] == "Type" {
            alertOK(titel: "Error", message: "Required fields: Name and Type")
        } else if editModel == false {
            setImageModel()
            setModel()
            StorageManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            navigationController?.popViewController(animated: true)
            tableView.reloadData()
        } else {
            setImageModel()
            StorageManager.shared.updateContactModel(model: contactModel, nameArray: cellNameArray, imageData: dataImage)
            navigationController?.popViewController(animated: true)
        }
    }
    
}

extension OptionContactTableViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
    
}

