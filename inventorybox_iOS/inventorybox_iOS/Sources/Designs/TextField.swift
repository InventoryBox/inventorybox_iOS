//
//  TextField.swift
//  DatePicker
//
//  Created by 이재용 on 2020/07/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class TextField: UITextField {

    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
}
