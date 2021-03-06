//
//  SPNewPackageViewController.swift
//  giaohanggiare
//
//  Created by Quan Tran on 12/6/17.
//  Copyright © 2017 Quan Tran. All rights reserved.
//

import UIKit

enum SPStateCellType {
    case info
    case expand
    case collapse
}

protocol SPCustomCollectionCellDelegate {
    func onTextFieldDidBeginEdit(_ textField: UITextField, at: IndexPath)
    func onTextFieldDidEndEdit(_ textField: UITextField, at: IndexPath)
}

protocol SPPackageInfoCellDelegate: SPCustomCollectionCellDelegate {
    
}

class SPNewPackageViewController: BaseViewController {
    
    var bottomSpacingConstraint: NSLayoutConstraint!
    
    //
    var currentNewPackage:SPPackageItem!
    
    var mainContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var packageTableView:SPCollectionView!
    
    var keyboardOnShow:Bool = false
    
    let cellId = "CollectionId"
    
    let infoPackageCellId = "InfoPackageCellId"
    let detailPackageCellId = "DetailPackageCellId"
    
    let termsAndCreatePackageCellId = "TermsAndCreatePackageCellId"
    
    let personalCellId = "PersonalCollectionId"
    let personalReceiverCellId = "personalReceiverCellId"
    let packageInfoCellId = "packageInfoCellId"
    
    let personalHeaderId = "PersonalHeaderId"
    let packageInfoHeaderId = "packageInfoHeaderId"
    let personalFooterId = "PersonalFooterId"
    
    
    var stateInfoCell: SPStateCellType = .expand
    var stateDetailCell: SPStateCellType = .info
    
    
    var backButtonBarItem: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "back-btnicon"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(canceldAddPackage), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 35)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    
//    var bottomStackView: UIStackView = {
//        let stackView = UIStackView(frame: .zero)
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.spacing = 5.0
//        return stackView
//    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
        setupData()
        
        self.navigationItem.leftBarButtonItem = backButtonBarItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(SPEditSenderViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SPEditSenderViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        addGestureForViewEdit()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.packageTableView.collectionViewLayout.invalidateLayout()
    }
    
    func addGestureForViewEdit() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnView)))
    }
    
    @objc func tapOnView() {
        if keyboardOnShow {
            keyboardOnShow = true
            view.endEditing(true)
        }
    }
    
    @objc func completedAddPackage(sender: UIBarButtonItem) {
//        let package = SPPackageItem()
//
//        let rerult = SPPackageViewModel.shareInstance.addPackage(package)
//        if !rerult.success {
//
//        }
    }
    
    @objc func canceldAddPackage(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let endFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameHeight = endFrame?.size.height ?? 0.0
        if let userInfo = notification.userInfo {
            let duration:TimeInterval = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.0
            let animationCurveRawNSN:NSNumber = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)!
            let animationCurveRaw = animationCurveRawNSN.uintValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            self.mainContainerView.moveUpViewToHeight(height: endFrameHeight)
                            self.packageTableView.isScrollEnabled = true
                            
            },
                           completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let duration:TimeInterval = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.0
            let animationCurveRawNSN:NSNumber = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)!
            let animationCurveRaw = animationCurveRawNSN.uintValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            self.mainContainerView.moveUpViewToHeight(height: 0.0)
                            self.packageTableView.isScrollEnabled = true
            },
                           completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func initView() {
        self.navigationItem.title = StringAppTitle.CREATE_PACKAGE_TITLE
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .undo, target: self, action: #selector(backBarButtonOnTouch))
        
        view.backgroundColor = .gray
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        
        packageTableView = SPCollectionView(type:.create, frame:.zero, layout: flowLayout)
        
        // Cells
        packageTableView.register(SPCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        packageTableView.register(SPInfoPackageViewCell.self, forCellWithReuseIdentifier: infoPackageCellId)
        packageTableView.register(SPDetailPackageViewCell.self, forCellWithReuseIdentifier: detailPackageCellId)
        packageTableView.register(SPTermsAndCreateViewCell.self, forCellWithReuseIdentifier: termsAndCreatePackageCellId)
        
        
        packageTableView.register(SPPersonalInfoCell.self, forCellWithReuseIdentifier: personalCellId)
        packageTableView.register(SPPersonalInfoCell.self, forCellWithReuseIdentifier: personalReceiverCellId)
        packageTableView.register(SPDetailPackageViewCell.self, forCellWithReuseIdentifier: packageInfoCellId)
        
        // Show scrolls
        packageTableView.showsVerticalScrollIndicator = true
        packageTableView.showsHorizontalScrollIndicator = true
        packageTableView.isScrollEnabled = true
        
        // Headers
        packageTableView.register(SPPersonalHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: personalHeaderId)
        packageTableView.register(SPPackageHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: packageInfoHeaderId)
        packageTableView.register(SPPersonalHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: personalFooterId)
        
        packageTableView.backgroundColor = .clear
        
        // Delegate
        packageTableView.setDelegateAndDataSource(self, dataSource: self)
        
        // Add tableView and setConstraints
        
        view.addSubview(mainContainerView)
        
        mainContainerView.addSubview(packageTableView)
        
        if #available(iOS 11.0, *) {
            mainContainerView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, topConstant: 5.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 5.0, widthConstant: 0.0, heightConstant: 0.0)
        } else {
            // Fallback on earlier versions
            mainContainerView.anchor(view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, topConstant: 5.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 5.0, widthConstant: 0.0, heightConstant: 0.0)
        }
        packageTableView.anchor(mainContainerView.topAnchor, left: mainContainerView.leftAnchor, right: mainContainerView.rightAnchor, bottom: mainContainerView.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
        
        packageTableView.contentSize = CGSize(width: view.frame.width, height: 600)
        
        
        // Add Bottom stackView
    }
    
    func setupData() {
        if currentNewPackage == nil {
            currentNewPackage = SPPackageItem(userInfo: SPUserManager.shareInstance.currentUserInfo)
        } else {
            
        }
        currentNewPackage.receiverCustomer = SPCustomerInfoItem(.receiver)
    }
    
    @objc func backBarButtonOnTouch(sender: UIBarButtonItem)  {
        print("backBarButtonOnTouch onclick")
        self.navigationController?.popViewController(animated: true)
    }
}

extension SPNewPackageViewController: SPCollectionViewDataSource, SPCollectionViewDelegate, SPPackageInfoCellDelegate {
    
    // MARK: SPPackageInfoCellDelegate
    func onTextFieldDidBeginEdit(_ textField: UITextField, at: IndexPath) {
        
        guard let sectionHeaderAttributes: UICollectionViewLayoutAttributes = self.packageTableView.layoutAttributesForItem(at: at as IndexPath)  else {
            return
        }
        guard let itemAttributes: UICollectionViewLayoutAttributes = self.packageTableView.layoutAttributesForSupplementaryElement(ofKind: UICollectionElementKindSectionHeader, at: at as IndexPath)  else {
            return
        }

       let combinedFrame: CGRect = CGRect(x: sectionHeaderAttributes.frame.origin.x, y: sectionHeaderAttributes.frame.origin.y + 50.0, width: sectionHeaderAttributes.frame.width, height: sectionHeaderAttributes.frame.height + itemAttributes.frame.height)

        self.packageTableView.scrollRectToVisible(combinedFrame, animated: false);
    }
    
    func onTextFieldDidEndEdit(_ textField: UITextField, at: IndexPath) {
        
    }
    
    
    func numberOfSections() -> Int {
        return 4
    }
    
    func numberOfItemsInSection(_ collectionView: UICollectionView, section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        return 1
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personalCellId, for: indexPath) as! SPPersonalInfoCell
//            cell.backgroundColor = .white
//            cell.delegateInfo = self
//            cell.setDataForCell(currentNewPackage.senderCustomer)
//            cell.indexSection = indexPath.section
//            return cell
//        }
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoPackageCellId, for: indexPath) as! SPInfoPackageViewCell
            cell.backgroundColor = .white
            cell.delegateInfo = self
            cell.setDataForCell(currentNewPackage.senderCustomer)
            cell.indexSection = indexPath.section
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailPackageCellId, for: indexPath) as! SPDetailPackageViewCell
            cell.backgroundColor = .white
            cell.delegateInfo = self
            cell.setDataForCell(currentNewPackage.senderCustomer)
            cell.indexSection = indexPath.section
            cell.isHidden = true
            return cell
        }
        else if (indexPath.section == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailPackageCellId, for: indexPath) as! SPDetailPackageViewCell
            cell.backgroundColor = .white
            cell.delegateInfo = self
            cell.setDataForCell(currentNewPackage.senderCustomer)
            cell.indexSection = indexPath.section
            cell.isHidden = true
            return cell
        }
        else if (indexPath.section == 3){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: termsAndCreatePackageCellId, for: indexPath) as! SPTermsAndCreateViewCell
            cell.cellDelegate = self
            cell.isHidden = false
            cell.backgroundColor = .white
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .green
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        
        var heightForCell: CGFloat = 160;
        switch indexPath.section {
        case 0:
            if stateInfoCell == .info {
                heightForCell = 0.0
            } else {
                heightForCell = 270
            }
            break
            
        case 1:
            if stateDetailCell == .info {
                heightForCell = 0.0
            } else {
                heightForCell = 270
            }
            break
        case 2:
//            if stateDetailCell == .info {
//                heightForCell = 0.0
//            } else {
                heightForCell = 0.0
//            }
            break
            
        case 3:
//            if stateDetailCell == .info {
//                heightForCell = 0.0
//            } else {
                heightForCell = 75.0
//            }
            break
        default:
            heightForCell = 0.0;
            break
        }
        
        return CGSize(width: collectionView.frame.width, height: heightForCell)
    }
    
    
    func viewForSupplementaryElementOfKind(_ collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                let header:SPPersonalHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalHeaderId, for: indexPath) as! SPPersonalHeaderCell)
                header.backgroundColor = .white
                header.setHeaderTitleWithString(string: "info_get_and_send_package_header".localized(withComment: "with!!!"))
                return header;
            } else if (indexPath.section == 1) {
                let header:SPPersonalHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalHeaderId, for: indexPath) as! SPPersonalHeaderCell)
                header.backgroundColor = .white
                header.setHeaderTitleWithString(string: "info_detail_package_header".localized(withComment: "with!!!"))
                return header;
            }
            else {
                let header:SPPackageHeaderCell = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: packageInfoHeaderId, for: indexPath) as! SPPackageHeaderCell)
                header.backgroundColor = .white
                header.setHeaderTitleWithString(string: "Thông tin đơn hàng")
                header.isHidden = true
                return header;
            }
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: personalFooterId, for: indexPath)
            footer.backgroundColor = .green
            return footer
        }
    }
    
    func referenceSizeForHeaderInSection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize {
        var heightForCell: CGFloat = 35.0;
        switch section {
        case 2:
            heightForCell = 0.0
            break
        case 3:
            heightForCell = 0.0
            break
        default:
//            heightForCell = 0.0;
            break
        }
        return CGSize(width: collectionView.frame.width - 5*2, height: heightForCell)
    }
    func referenceSizeForFooterInSection(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  section: Int) -> CGSize{
        return CGSize(width: collectionView.frame.width - 5*2, height: 0.0)
    }
}

extension SPNewPackageViewController: SPEditSenderDelegate {
    func didCancelEditInfo() {
        dismiss(animated: true, completion: nil)
    }
    
    func didDoneEditInfo(_ changeInfo: Bool, customerIsChange: SPCustomerInfoItem) {
        dismiss(animated: true) {
            if customerIsChange.customerType == .sender {
                self.currentNewPackage.senderCustomer = customerIsChange
            } else {
                self.currentNewPackage.receiverCustomer = customerIsChange
            }
            self.packageTableView.reloadData()
        }
    }
}

extension SPNewPackageViewController: SPPackageInfoDelegate {
    func editButtonOnTouchInside(sender: UIButton, atSection: NSInteger) {
        print("editInfoButtonOnTouch onTouchInSide AAAAA")
        
        let editViewController = self.storyboard?.instantiateViewController(withIdentifier: "SPEditSenderViewController") as! SPEditSenderViewController
        if atSection == 0 {
            editViewController.customerInfo = currentNewPackage.senderCustomer
        } else {
            editViewController.customerInfo = currentNewPackage.receiverCustomer
        }
        
        editViewController.delegate = self
        
        let navigationController1 = UINavigationController(rootViewController: editViewController)
        navigationController1.modalPresentationStyle = .overCurrentContext
        navigationController1.modalTransitionStyle = .crossDissolve
        navigationController1.providesPresentationContextTransitionStyle = true;
        navigationController1.definesPresentationContext = true;
        present(navigationController1, animated: true, completion: {
            print("Present Edit Sender View Controller is completed!")
        })
        navigationController1.popoverPresentationController?.sourceView = view
        let frameView:CGRect = view.frame;
        navigationController1.popoverPresentationController?.sourceRect = frameView
    }
}

extension SPNewPackageViewController: SPTermsAndCreateDelegate {
    func didCreatePackageButtonOnTouchInside(sender: UIButton) {
        SPPackageViewModel.shareInstance.addPackage(nil) { (success, errorMsg) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

//extension SPNewPackageViewController: SPReceiverInfoViewCellDelegate {
//    func selectedAtIndexTextField(point: CGPoint, atSection: NSInteger) {
//        if atSection >= 0 {
//            let i = IndexPath(row: 0, section: 2)
//            self.packageTableView.scrollToItem(at: i, at: .top, animated: true)
//        }
//    }
//}

//class SPDetailPackageViewCell: SPCollectionViewCell, UITextFieldDelegate {
//    
//    var cellDelegate: SPPackageInfoCellDelegate!
//    
//    var packageSizeTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Kich thuoc"
//        tf.setBottomBorder()
//        tf.returnKeyType = UIReturnKeyType.done
//        return tf
//    }()
//    
//    var packageSizeLabel: UILabel = {
//        var label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.font = UIFont.systemFont(ofSize: 14.0)
//        label.text = "cm"
//        return label
//    }()
//    
//    var packageWeightTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Khoi luong"
//        tf.setBottomBorder()
//        tf.returnKeyType = UIReturnKeyType.done
//        return tf
//    }()
//    
//    var packageWeightLabel: UILabel = {
//        var label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.font = UIFont.systemFont(ofSize: 14.0)
//        label.text = "kg"
//        return label
//    }()
//    
//    var packageNoteTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Ghi chu"
//        tf.setBottomBorder()
//        tf.returnKeyType = UIReturnKeyType.done
//        return tf
//    }()
//    
//    var packageCODButton: UIButton = {
//        var button = UIButton(frame: .zero)
//        button.backgroundColor = .green
//        return button
//    }()
//    
//    var packageCODLabel: UILabel = {
//        var label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.font = UIFont.systemFont(ofSize: 14.0)
//        label.text = "Thu ho"
//        return label
//    }()
//    
//    var packageCODTextField:UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.placeholder = "Thu ho"
//        tf.setBottomBorder()
//        tf.returnKeyType = UIReturnKeyType.done
//        return tf
//    }()
//    
//    var packageSenderPayButton: UIButton = {
//        var button = UIButton(frame: .zero)
//        button.backgroundColor = .green
//        return button
//    }()
//    
//    var packageSenderPayLabel: UILabel = {
//        var label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.font = UIFont.systemFont(ofSize: 14.0)
//        label.text = "Nguoi gui tra"
//        return label
//    }()
//    
//    var packageReceiverPayButton: UIButton = {
//        var button = UIButton(frame: .zero)
//        button.backgroundColor = .green
//        return button
//    }()
//    
//    var packageReceiverPayLabel: UILabel = {
//        var label = UILabel(frame: .zero)
//        label.backgroundColor = .clear
//        label.font = UIFont.systemFont(ofSize: 14.0)
//        label.text = "Nguoi nhan tra"
//        return label
//    }()
//
//    override func setupView() {
//        
//        self.contentView.addSubview(packageSizeTextField)
//        self.contentView.addSubview(packageSizeLabel)
//        self.contentView.addSubview(packageWeightLabel)
//        self.contentView.addSubview(packageWeightTextField)
//        self.contentView.addSubview(packageNoteTextField)
//        
//        self.contentView.addSubview(packageCODButton)
//        self.contentView.addSubview(packageCODLabel)
//        self.contentView.addSubview(packageCODTextField)
//        
//        self.contentView.addSubview(packageSenderPayButton)
//        self.contentView.addSubview(packageSenderPayLabel)
//        
//        self.contentView.addSubview(packageReceiverPayButton)
//        self.contentView.addSubview(packageReceiverPayLabel)
//        
//        // Add Constraints
//        packageSizeTextField.anchor(topAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: contentView.frame.width/2 - 25 - 4.0, heightConstant: 30.0)
//        
//        packageSizeLabel.anchor(topAnchor, left: packageSizeTextField.rightAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 30.0)
//        
//        
//        packageWeightLabel.anchor(topAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 30.0)
//        
//        packageWeightTextField.anchor(topAnchor, left: nil, right: packageWeightLabel.leftAnchor, bottom: nil, topConstant: 2, leftConstant: 0.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: contentView.frame.width/2 - 25 - 4.0, heightConstant: 30.0)
//        
//        packageNoteTextField.anchor(packageSizeTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 30.0)
//        
//        
//        packageCODButton.anchor(packageNoteTextField.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 30.0, heightConstant: 30.0)
//        
//        packageCODLabel.anchor(packageNoteTextField.bottomAnchor, left: packageCODButton.rightAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 80.0, heightConstant: 30.0)
//        
//        packageCODTextField.anchor(packageNoteTextField.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 150.0, heightConstant: 30.0)
//        
//        
//        packageSenderPayButton.anchor(packageCODButton.bottomAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 30.0, heightConstant: 30.0)
//        
//        packageSenderPayLabel.anchor(packageCODButton.bottomAnchor, left: packageSenderPayButton.rightAnchor, right: nil, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 30.0)
//        
//        packageReceiverPayLabel.anchor(packageCODButton.bottomAnchor, left: nil, right: rightAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 120.0, heightConstant: 30.0)
//        
//        packageReceiverPayButton.anchor(packageCODButton.bottomAnchor, left: nil, right: packageReceiverPayLabel.leftAnchor, bottom: nil, topConstant: 2, leftConstant: 2.0, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 30.0, heightConstant: 30.0)
//        
//        packageSizeTextField.delegate = self
//        
//        packageWeightTextField.delegate = self
//        
//        packageCODTextField.delegate = self
//    }
//    
//    func editInfoButtonOnTouch(sender: UIButton)  {
//        print("editInfoButtonOnTouch onTouchInSide")
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == packageNoteTextField {
//            print("This is a Note TextField!")
//            return
//        }
//        guard let delegate = self.cellDelegate else {
//            return
//        }
//        delegate.onTextFieldDidBeginEdit(textField, at: IndexPath(row: 1, section: 2))
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let delegate = self.cellDelegate else {
//            return
//        }
//        delegate.onTextFieldDidEndEdit(textField, at: IndexPath(row: 1, section: 2))
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            textField.resignFirstResponder()
//            return true;
//        }
//        return false
//    }
//}


protocol SPTermsAndCreateDelegate {
    func didCreatePackageButtonOnTouchInside(sender: UIButton)
}


class SPTermsAndCreateViewCell: SPCollectionViewCell, UITextFieldDelegate, SPCreateFunctionDelegate {
    
    var cellDelegate: SPTermsAndCreateDelegate!
    
    var mainCellStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5.0
        return stackView
    }()
    
    
    var termsView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    
    var checkTermsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ""), for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    var termStringLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .green
        label.text = "terms_read_and_agree_to_create_package".localized(withComment: "")
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = .black
        return label
    }()
    
    var readTermsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("terms_button_title".localized(withComment: ""), for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    
    var createButtonView: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    let functions = SPCreateFunctions()
    
    lazy var createPackageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("button_create_package_title".localized(withComment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.backgroundColor = UIColor.rgb(r: 28, g: 127, b: 97)
        button.addTarget(functions, action: #selector(SPCreateFunctions.createPackageButtonOnTouchInside), for: .touchUpInside)
        return button
    }()
    
    
    override func setupView() {
        super.setupView()
        
        functions.cellDelegate = self as SPCreateFunctionDelegate
        
        addSubview(mainCellStackView)
        
        mainCellStackView.addArrangedSubview(termsView)
        mainCellStackView.addArrangedSubview(createButtonView)
        mainCellStackView.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
        
        // Terms
        termsView.addSubview(checkTermsButton)
        termsView.addSubview(termStringLabel)
        termsView.addSubview(readTermsButton)
        
        checkTermsButton.anchor(termsView.centerYAnchor, left: leftAnchor, right: nil, bottom: nil, topConstant: -10.0, leftConstant: 5.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 20.0, heightConstant: 20.0)
        termStringLabel.anchor(termsView.topAnchor, left: checkTermsButton.rightAnchor, right: nil, bottom: termsView.bottomAnchor, topConstant: 0.0, leftConstant: 3.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 130.0, heightConstant: 0.0)
        
        readTermsButton.anchor(termsView.topAnchor, left: termStringLabel.rightAnchor, right: nil, bottom: termsView.bottomAnchor, topConstant: 0.0, leftConstant: -3.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 130.0, heightConstant: 0.0)
        
        createButtonView.addSubview(createPackageButton)
        createPackageButton.anchor(createButtonView.topAnchor, left: createButtonView.leftAnchor, right: createButtonView.rightAnchor, bottom: createButtonView.bottomAnchor, topConstant: 0.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: -5.0, widthConstant: 0.0, heightConstant: 0.0)
    }
    
    @objc public func createPackageButtonOnTouchInside(sender: UIButton)  {
        print("editInfoButtonOnTouch onTouchInSide")
        if let delegate = self.cellDelegate {
            delegate.didCreatePackageButtonOnTouchInside(sender: sender)
        }
    }
    
    func didCreatePackageFunctionDelegate(sender: UIButton) {
        if let delegate = self.cellDelegate {
            delegate.didCreatePackageButtonOnTouchInside(sender: sender)
        }
    }
    
}

protocol SPCreateFunctionDelegate {
    func didCreatePackageFunctionDelegate(sender: UIButton)
}

class SPCreateFunctions {
    var cellDelegate: SPCreateFunctionDelegate!
    @objc func createPackageButtonOnTouchInside(sender: UIButton) {
        print("editInfoButtonOnTouch onTouchInSide")
        if let delegate = self.cellDelegate {
            delegate.didCreatePackageFunctionDelegate(sender: sender)
        }
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func setRightImageView(image: UIImage, size:CGSize)  {
        let imageView = UIImageView()
        imageView.image = image
        imageView.backgroundColor = .clear
        imageView.frame = CGRect(x: 0, y: 0.0, width: size.width, height: size.height)
        
        self.rightView = imageView
        self.rightViewMode = .always
    }
}

class SPPersonalHeaderCell: UICollectionReusableView {
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = ""
        return label
    }()
    
    var lineView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        addSubview(nameLabel)
        addSubview(lineView)
        
        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 0.0, heightConstant: 0.0)
        
        lineView.anchor(nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, bottom: nil, topConstant: 1, leftConstant: 2, rightConstant: -2.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 1.0)
    }
    
    public func setHeaderTitleWithString(string: String) {
        // Name Label
        var attributes = [NSAttributedStringKey: Any]()
        attributes[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: 15.0)
        attributes[NSAttributedStringKey.foregroundColor] = UIColor.rgb(r: 28, g: 157, b: 97)
        let attString1 = NSAttributedString(string: string, attributes: attributes)
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        nameLabel.attributedText = finalAttString
    }
}

class SPPackageHeaderCell: UICollectionReusableView {
    
    var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.text = ""
        return label
    }()
    
    var modePackageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "ABC 123"
        return label
    }()
    
    var modePackageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(showDropDownOnTouchInside), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    var isDropDownShow: Bool = false
    
    
//    var modePackageView: DropDown = {
//        let dropDown = DropDown()
//
//        // The view to which the drop down will appear on
//        //dropDown.anchorView = view // UIView or UIBarButtonItem
//
//        // The list of items to display. Can be changed dynamically
//        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
//
//        return dropDown
//    }()
    
    @objc func showDropDownOnTouchInside(sender: UIButton) {
//        if !isDropDownShow {
//            isDropDownShow = true
//            modePackageView.show()
//        } else {
//            isDropDownShow = false
//            modePackageView.hide()
//        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
        addSubview(nameLabel)
        addSubview(modePackageLabel)
        addSubview(modePackageButton)
        nameLabel.anchor(topAnchor, left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 0.0, heightConstant: 0.0)
        modePackageLabel.anchor(topAnchor, left: nil, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 120.0, heightConstant: 0.0)
        modePackageButton.anchor(topAnchor, left: nil, right: rightAnchor, bottom: bottomAnchor, topConstant: 2, leftConstant: 2, rightConstant: -2.0, bottomConstant: -2.0, widthConstant: 120.0, heightConstant: 0.0)
//        modePackageView.anchorView = modePackageLabel
//        modePackageView.direction = .bottom
        isDropDownShow = false
    }
    
    public func setHeaderTitleWithString(string: String) {
        // Name Label
        var attributes = [NSAttributedStringKey: Any]()
        attributes[NSAttributedStringKey.font] = UIFont.boldSystemFont(ofSize: 15.0)
        attributes[NSAttributedStringKey.foregroundColor] = UIColor.rgb(r: 28, g: 157, b: 97)
        let attString1 = NSAttributedString(string: string, attributes: attributes)
        let finalAttString: NSMutableAttributedString = NSMutableAttributedString(attributedString: attString1)
        nameLabel.attributedText = finalAttString
        
    }
}

class SPCheckBoxButton: UIButton {
    var customTitle: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = ""
        return label
    }()
    
    var heightForCheckBox: CGFloat = 35.0 {
        didSet{
            checkImageView.updateHeightAnchorWithConstant(heightForCheckBox)
            checkImageView.updateWidthAnchorWithConstant(heightForCheckBox)
            checkImageView.layer.cornerRadius = heightForCheckBox/2.0
        }
    }
    
    var checkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "button_checked"))
        imageView.backgroundColor = UIColor.rgb(r: 109, g: 192, b: 94)
        return imageView
    }()
    
    var checkState: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = .yellow
        self.addSubview(checkImageView)
        self.addSubview(customTitle)
        
        checkImageView.anchor(self.centerYAnchor, left: self.leftAnchor, right: nil, bottom: nil, topConstant: -(heightForCheckBox/2.0), leftConstant: 2.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: heightForCheckBox, heightConstant: heightForCheckBox)
        
        checkImageView.layer.cornerRadius = heightForCheckBox/2.0
        
        customTitle.anchor(self.topAnchor, left: checkImageView.rightAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, topConstant: 0.0, leftConstant: 5.0, rightConstant: -5.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant:0.0)
    }
    
    public func setFontForLabel(_ font: UIFont) {
        customTitle.font = font
    }
    
    public func updateCheckStateButton() {
        if checkState == false {
            checkState = true
            let imageChecked = UIImage(named: "button_checked.png")
            self.checkImageView.image = imageChecked
            self.checkImageView.backgroundColor = .white
        } else {
            checkState = false
            self.checkImageView.image = nil
            self.checkImageView.backgroundColor = UIColor.rgb(r: 109, g: 192, b: 94)
        }
    }
    
    public func setTitleForCheckBox(_ title: String) {
        self.customTitle.text = title
    }
}

class SPDropDownButton: UIButton, UITextFieldDelegate {
    
    let dropDownItemCellId: String = "dropDownItemCellId"
    
    var valueTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.backgroundColor = .clear
        tf.text = ""
        tf.font = UIFont.systemFont(ofSize: 13.0)
        return tf
    }()
    
    var dropdownImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "button_dropdown"))
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var mainContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var itemsCollectionView: UICollectionView = {
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.minimumLineSpacing = 0.5
//        layout.itemSize = CGSize(width: 90, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var listItems: NSArray = NSArray()
    var defaultIndexSelected:Int = 0 {
        didSet {
            if defaultIndexSelected < self.listItems.count {
                guard let string: String = self.listItems.object(at: defaultIndexSelected) as? String else {
                    return
                }
                self.valueTextField.text = string
            }
        }
    }
    
    
    var heightForCheckBox: CGFloat = 35.0 {
        didSet{
            
        }
    }
    
    var checkState: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.backgroundColor = UIColor.rgb(r: 245.0, g: 245.0, b: 245.0)
        self.addSubview(valueTextField)
        self.addSubview(dropdownImageView)
        self.addSubview(mainContainerView)
        
        mainContainerView.addSubview(itemsCollectionView)
        
        valueTextField.anchor(self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 3.0, rightConstant: -35.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 25.0)
        
        dropdownImageView.anchor(self.topAnchor, left: nil, right: self.rightAnchor, bottom: nil, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 25.0, heightConstant: 25.0)
        
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5.0
        
        itemsCollectionView.anchor(mainContainerView.topAnchor, left: mainContainerView.leftAnchor, right: mainContainerView.rightAnchor, bottom: mainContainerView.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
        
        
        valueTextField.delegate = self
        
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        itemsCollectionView.register(SPDropDownItemCollectionCell.self, forCellWithReuseIdentifier: dropDownItemCellId)
        
        self.mainContainerView.isHidden = true
    }
    
    public func setSelectedValueForCheckBox(_ value: String) {
        self.valueTextField.text = value
    }
    
    public func showDropDownItemsView() {
        self.mainContainerView.isHidden = false
        self.itemsCollectionView.reloadData()
        self.mainContainerView.frame = CGRect(x: 0, y: 35.0, width: self.frame.width, height: 0.0)
        UIView.animate(withDuration: 0.4,
                       delay: TimeInterval(0),
                       options: .curveLinear,
                       animations: {
                        self.mainContainerView.frame = CGRect(x: 0, y: 35.0, width: self.frame.width, height: 3*(35.0))
                        self.updateHeightAnchorWithConstant(4*(35.0))
        },
                       completion: nil)
    }
    
    public func hideDropDownItemsView() {
        self.itemsCollectionView.reloadData()
        self.mainContainerView.frame = CGRect(x: 0, y: 35.0, width: self.frame.width, height: 0.0)
        UIView.animate(withDuration: 0.4,
                       delay: TimeInterval(0),
                       options: .curveLinear,
                       animations: {
                        self.mainContainerView.frame = CGRect(x: 0, y: 35.0, width: self.frame.width, height: 0)
                        self.mainContainerView.isHidden = true
                        self.updateHeightAnchorWithConstant(35.0)
        },
                       completion: nil)
        
    }
    
    public func setListItemsWithArray(_ array: NSArray) {
        self.listItems = array
        self.itemsCollectionView .reloadData()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.showDropDownItemsView()
        return false
    }
}

extension SPDropDownButton: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dropDownItemCellId, for: indexPath) as! SPDropDownItemCollectionCell
        guard let string: String = listItems.object(at: indexPath.row) as? String else {
            return cell
        }
        cell.titleLabel.text = string
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defaultIndexSelected = indexPath.row
        self.hideDropDownItemsView()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-5.0, height: 30.0)
    }
}

class SPDropDownItemCollectionCell: UICollectionViewCell {
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.contentView.backgroundColor = .black
        self.addSubview(titleLabel)
        titleLabel.anchor(self.contentView.topAnchor, left: self.contentView.leftAnchor, right: self.contentView.rightAnchor, bottom: self.contentView.bottomAnchor, topConstant: 0.0, leftConstant: 0.0, rightConstant: 0.0, bottomConstant: 0.0, widthConstant: 0.0, heightConstant: 0.0)
    }
    
}
