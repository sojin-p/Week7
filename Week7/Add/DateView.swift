//
//  DateView.swift
//  Week7
//
//  Created by 박소진 on 2023/08/29.
//

import UIKit

class DateView: BaseView {
    
    let picker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .wheels
        view.datePickerMode = .date
        return view
    }()
    
    override func configureView() {
        addSubview(picker)
    }
    
    override func setConstraints() {
        picker.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
