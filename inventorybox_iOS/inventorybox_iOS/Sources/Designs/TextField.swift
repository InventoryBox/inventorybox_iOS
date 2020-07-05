//
//  TextField.swift
//  DatePicker
//
//  Created by 이재용 on 2020/07/04.
//  Copyright © 2020 jaeyong Lee. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    // textField 커서 없애기 및 복붙 안되게 만들기 
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
}
