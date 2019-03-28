//
//  _CTVFLUnarySyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol _CTVFLUnarySyntax: CTVFLOperand {
    associatedtype Operand: CTVFLOperand
    
    var operand: Operand { get }
    
    func attributeForContainer(at side: CTVFLLayoutAnchorSelectableSide, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute
}

extension _CTVFLUnarySyntax {
    public func attributeForContainer(at side: CTVFLLayoutAnchorSelectableSide, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch side {
        case .lhs:
            switch orientation {
            case .horizontal:
                if (rawOptions & _rawDirectionLeftToRight) != 0 {
                    return .left
                } else if (rawOptions & _rawDirectionRightToLeft) != 0 {
                    return .right
                } else {
                    return .leading
                }
            case .vertical:
                #if os(iOS) || os(tvOS)
                if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                    if (rawOptions & _rawSpacingBaselineToBaseline) != 0 {
                        return .firstBaseline
                    }
                }
                return .top
                #elseif os(macOS)
                return .top
                #endif
            }
        case .rhs:
            switch orientation {
            case .horizontal:
                if (rawOptions & _rawDirectionLeftToRight) != 0 {
                    return .right
                } else if (rawOptions & _rawDirectionRightToLeft) != 0 {
                    return .left
                } else {
                    return .trailing
                }
            case .vertical:
                #if os(iOS) || os(tvOS)
                if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                    if (rawOptions & _rawSpacingBaselineToBaseline) != 0 {
                        return .lastBaseline
                    }
                }
                return .bottom
                #elseif os(macOS)
                return .bottom
                #endif
            }
        }
    }
}

extension _CTVFLUnarySyntax where Self: CTVFLObjectBasedOperand, Operand: CTVFLObjectBasedOperand {
    public func attributeForBeingConstrained(at side: CTVFLLayoutAnchorSelectableSide, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLOptions)-> CTVFLLayoutAttribute {
        return operand.attributeForBeingConstrained(at: side, forOrientation: orientation, withOptions: options)
    }
}

#if os(iOS) || os(tvOS)
@available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *)
let _rawSpacingBaselineToBaseline = CTVFLOptions.spacingBaselineToBaseline.rawValue
#endif
let _rawDirectionLeftToRight = CTVFLOptions.directionLeftToRight.rawValue
let _rawDirectionRightToLeft = CTVFLOptions.directionRightToLeft.rawValue
