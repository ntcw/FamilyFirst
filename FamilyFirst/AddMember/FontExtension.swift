//
//  FontExtension.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 08.07.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

extension UIFont{
    
    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont
    {
        return withTraits(traits: .traitBold)
    }
}


