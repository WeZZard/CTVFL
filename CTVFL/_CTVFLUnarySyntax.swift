//
//  _CTVFLUnarySyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol _CTVFLUnarySyntax: CTVFLOperand {
    associatedtype Operand: CTVFLOperand
    
    var operand: Operand { get }
    
    func attributeForContainer(at side: CTVFLNSLayoutConstrainedSide, forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: NSLayoutFormatOptions) -> NSLayoutAttribute
}

extension _CTVFLUnarySyntax {
    public func attributeForContainer(at side: CTVFLNSLayoutConstrainedSide, forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: NSLayoutFormatOptions) -> NSLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch side {
        case .lhs:
            switch orientation {
            case .horizontal:
                if (rawOptions & rawDirectionLeftToRight) != 0 {
                    return .left
                } else if (rawOptions & rawDirectionRightToLeft) != 0 {
                    return .right
                } else {
                    return .leading
                }
            case .vertical:
                #if os(iOS) || os(tvOS)
                if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                    if (rawOptions & rawSpacingBaselineToBaseline) != 0 {
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
                if (rawOptions & rawDirectionLeftToRight) != 0 {
                    return .right
                } else if (rawOptions & rawDirectionRightToLeft) != 0 {
                    return .left
                } else {
                    return .trailing
                }
            case .vertical:
                #if os(iOS) || os(tvOS)
                if #available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *) {
                    if (rawOptions & rawSpacingBaselineToBaseline) != 0 {
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

extension _CTVFLUnarySyntax where Self: CTVFLLayoutableOperand, Operand: CTVFLLayoutableOperand {
    public func attributeForBeingConstrained(at side: CTVFLNSLayoutConstrainedSide, forOrientation orientation: CTVFLNSLayoutConstrainedOrientation, withOptions options: NSLayoutFormatOptions) -> NSLayoutAttribute
    {
        return operand.attributeForBeingConstrained(at: side, forOrientation: orientation, withOptions: options)
    }
}

@available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *)
let rawSpacingBaselineToBaseline = CTVFLOptions.spacingBaselineToBaseline.rawValue
let rawDirectionLeftToRight = CTVFLOptions.directionLeftToRight.rawValue
let rawDirectionRightToLeft = CTVFLOptions.directionRightToLeft.rawValue
