//
//  ViewController.swift
//  PickerSelect
//
//  Created by Takuya Aso on 2019/07/20.
//  Copyright © 2019 Takuya Aso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    // 以前選択されたデータのindexを保存する用のプロパティ(初期値は0)
    var pickerIndex: Int = 0

    private let array = ["ニャース", "ミズゴロウ", "ドガース"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.textField.delegate = self
        self.setUpUI()
    }

    private func setUpUI() {
        let toolbar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: 0.0,
                                              height: 44.0))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(self.done))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: self, action: nil)
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(self.cancel))
        toolbar.setItems([cancelItem, space, doneItem], animated: true)

        self.textField.inputView = pickerView
        self.textField.inputAccessoryView = toolbar
    }

    @objc
    private func done() {
        self.textField.endEditing(true)
    }

    @objc
    private func cancel() {
        self.textField.text = ""
        self.textField.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {

    /// TextFieldが編集中になった際に呼ばれる
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 前回選択されたindexの文字列を表示させる
        self.textField.text = self.array[self.pickerIndex]
    }
}

extension ViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textField.text = array[row]
        // 選択された際のデータのindexを代入
        self.pickerIndex = row
    }
}

extension ViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
}
