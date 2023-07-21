//
//  ViewController.swift
//  UIKit-lab-7
//
//  Created by Iliya Rahozin on 21.07.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIScrollViewDelegate {
    let imageHeight: CGFloat = 270

    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    let imageView: UIImageView = {
        let logoImage = UIImageView(image: UIImage(named: "porshe"))
        logoImage.contentMode = .scaleAspectFill
        logoImage.clipsToBounds = true
        return logoImage
    }()

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.showsVerticalScrollIndicator = true
        scroll.automaticallyAdjustsScrollIndicatorInsets = false
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = .white
        scroll.keyboardDismissMode = .onDrag
        scroll.delegate = self
        return scroll
    }()

    var imageHeightConstraint: Constraint?
    var imageTopConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Создание и настройка интерфейса

    func setupViews() {
        view.backgroundColor = .white
    }

    func addSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
    }

    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
            make.height.equalTo(2000)
        }

        imageView.snp.makeConstraints { make in
            imageTopConstraint = make.top.equalToSuperview().constraint
            make.leading.trailing.equalToSuperview()
            imageHeightConstraint = make.height.equalTo(imageHeight).constraint
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop

        if offset < 0 {
            currentTop = offset
            let updatedHeight = imageHeight - offset
            imageHeightConstraint?.update(offset: updatedHeight)
            scrollView.verticalScrollIndicatorInsets.top = updatedHeight
        } else {
            imageHeightConstraint?.update(offset: imageHeight)
            scrollView.verticalScrollIndicatorInsets.top = imageHeight
        }
        imageTopConstraint?.update(offset: currentTop)
    }

}
