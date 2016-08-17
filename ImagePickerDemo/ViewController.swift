//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by angcyo on 16/08/17.
//  Copyright © 2016年 angcyo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// 图片控件
	@IBOutlet weak var imageView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		imageView.userInteractionEnabled = true // 开启控件的交互操作, 否则轻触事件无法传递
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

//MARK: 轻触 图片控件
extension ViewController {

	// MARK: 用于弹出选择的对话框界面
	var selectorController: UIAlertController {
		let controller = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
		controller.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil)) // 取消按钮
		controller.addAction(UIAlertAction(title: "拍照选择", style: .Default) { action in
			self.selectorSourceType(.Camera)
		}) // 拍照选择
		controller.addAction(UIAlertAction(title: "相册选择", style: .Default) { action in
			self.selectorSourceType(.PhotoLibrary)
		}) // 相册选择
		return controller
	}

	// MARK: 轻触手势事件的回调
	@IBAction func onTapImageView(sender: UITapGestureRecognizer) {
		presentViewController(selectorController, animated: true, completion: nil)
	}

	func selectorSourceType(type: UIImagePickerControllerSourceType) {
		imagePickerController.sourceType = type
		// 打开图片选择器
		presentViewController(imagePickerController, animated: true, completion: nil)
	}
}

//MARK: 扩展图片选择和结果返回
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	// MARK: 图片选择器界面
	var imagePickerController: UIImagePickerController {
		get {
			let imagePicket = UIImagePickerController()
			imagePicket.delegate = self
			imagePicket.sourceType = .PhotoLibrary
			return imagePicket
		}
	}

	// MARK: 当图片选择器选择了一张图片之后回调
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
		dismissViewControllerAnimated(true, completion: nil) // 选中图片, 关闭选择器...这里你也可以 picker.dismissViewControllerAnimated 这样调用...但是效果都是一样的...

		imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage // 显示图片
		imageView.contentMode = .ScaleToFill // 缩放显示, 便于查看全部的图片
	}

	// MARK: 当点击图片选择器中的取消按钮时回调
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		picker.dismissViewControllerAnimated(true, completion: nil) // 效果一样的...
	}
}
