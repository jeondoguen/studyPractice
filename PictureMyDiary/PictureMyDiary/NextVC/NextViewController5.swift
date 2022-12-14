//
//  NextViewController5.swift
//  WriteDiary
//
//  Created by 전도균 on 2022/10/16.
//

import UIKit

class NextViewController5: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagPickUp5 : UIImagePickerController!
    var imageV5 = UIImageView()
    var writeV5 = UITextView()
    var writeTitle5 = UITextField()
    var currentDate = Date()
    let logoV = UIImageView()
    let datePicker = UIDatePicker()
    
    func imageAndVideos()-> UIImagePickerController{
        if(imagPickUp5 == nil){
            imagPickUp5 = UIImagePickerController()
            imagPickUp5.delegate = self
            imagPickUp5.allowsEditing = false
        }
        return imagPickUp5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 235/235, green: 235/235, blue: 226/235, alpha: 1)
        
        self.initTitleImage()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissSelf))

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissSelf))
        

        imagPickUp5 = self.imageAndVideos()
        
        let button = UIButton(frame: CGRect(x: 250, y: 420, width: 150, height: 50))
        
        button.setImage(UIImage(systemName: "camera.on.rectangle"), for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
        
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: logoV.bottomAnchor),
        ])
        
        imageV5 = UIImageView(frame: CGRect(x: 30, y: 180, width: 330, height: 250))
        imageV5.layer.cornerRadius = 10
        imageV5.clipsToBounds = true
        imageV5.layer.borderWidth = 2.0
        imageV5.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(imageV5)
        
        writeTitle5 = UITextField(frame: CGRect(x: 30, y: 460, width: 330, height: 30))
        writeTitle5.layer.cornerRadius = 10
        writeTitle5.clipsToBounds = true
        writeTitle5.layer.borderWidth = 1
        writeTitle5.layer.borderColor = UIColor.lightGray.cgColor
        writeTitle5.placeholder = " 제목을 입력하세요"
        view.addSubview(writeTitle5)
        
        writeV5 = UITextView(frame: CGRect(x: 30, y: 500, width: 330, height: 200))
        writeV5.layer.cornerRadius = 10
        writeV5.clipsToBounds = true
        writeV5.layer.borderWidth = 2.0
        writeV5.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(writeV5)
        
        let saveBt5 = UIButton(frame: CGRect(x: 120, y: 720, width: 150, height: 50))
        saveBt5.backgroundColor = .lightGray
        saveBt5.setTitle("Save", for: .normal)
        saveBt5.addTarget(self, action:#selector(self.save(_:)), for: .touchUpInside)
        saveBt5.layer.cornerRadius = 10
        self.view.addSubview(saveBt5)
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        currentDate = sender.date
    }
    
    @objc func buttonClicked() {
        let ActionSheet = UIAlertController(title: nil, message: "Select Photo", preferredStyle: .actionSheet)
        
        let cameraPhoto = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                
                self.imagPickUp5.mediaTypes = ["public.image"]
                self.imagPickUp5.sourceType = UIImagePickerController.SourceType.camera;
                self.present(self.imagPickUp5, animated: true, completion: nil)
            }
            else{
                UIAlertController(title: "iOSDevCenter", message: "No Camera available.", preferredStyle: .alert).show(self, sender: nil);
            }
            
        })
        
        let PhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                self.imagPickUp5.mediaTypes = ["public.image"]
                self.imagPickUp5.sourceType = UIImagePickerController.SourceType.photoLibrary;
                self.present(self.imagPickUp5, animated: true, completion: nil)
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        
        ActionSheet.addAction(cameraPhoto)
        ActionSheet.addAction(PhotoLibrary)
        ActionSheet.addAction(cancelAction)
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            let presentC : UIPopoverPresentationController  = ActionSheet.popoverPresentationController!
            presentC.sourceView = self.view
            presentC.sourceRect = self.view.bounds
            self.present(ActionSheet, animated: true, completion: nil)
        }
        else{
            self.present(ActionSheet, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageV5.image = image
        imagPickUp5.dismiss(animated: true, completion: { () -> Void in
            // Dismiss
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagPickUp5.dismiss(animated: true, completion: { () -> Void in
            // Dismiss
        })
    }
    
    @objc private func didTapButton() {
        let writeVC5 = UIViewController()
        writeVC5.view.backgroundColor = .white
        navigationController?.pushViewController(writeVC5, animated: true)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    func initTitleImage() {
        logoV.contentMode = .scaleAspectFit
        let logo = UIImage(named: "face2")
        logoV.image = logo
        view.addSubview(logoV)
        logoV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoV.widthAnchor.constraint(equalToConstant: 80),
            logoV.heightAnchor.constraint(equalToConstant: 80),
            logoV.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoV.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func save(_ sender: Any) {
        guard let title = writeTitle5.text,
                let memo = writeV5.text, memo.count > 0 else {
            alert(message: "내용을 입력해주세요")
            return
        }
        // 다른거에도 넣어줘야 됨
        Singleton.shared.title.append(title)
        Singleton.shared.description.append(memo)
        Singleton.shared.feeling.append("face2") // 기분 이미지 넣기
        Singleton.shared.writeDate.append(currentDate) // 저장한 날짜
        let formattedDate = convertDate(currentDate: currentDate)
        Singleton.shared.dateLast.append(formattedDate)
        Singleton.shared.insertDate.append(convertDateToMonthDay(currentDate: currentDate))
        
        if imageV5.image == nil {
            let alertController = UIAlertController(title: "경고", message: "이미지를 넣어주세요", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(confirmAction)
            present(alertController, animated: true)
        } else {
            Singleton.shared.image.append(imageV5.image!)
            SceneDelegate.tabBarController.selectedIndex = 2
            dismissSelf()
        }
    }
}

extension NextViewController5 {
    private func convertDate(currentDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateStr = dateFormatter.string(from: currentDate)
        return dateStr
    }
    
    private func convertDateToMonthDay(currentDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.dateFormat = "MM/dd(E)"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateStr = dateFormatter.string(from: currentDate)
        return dateStr
    }
}
