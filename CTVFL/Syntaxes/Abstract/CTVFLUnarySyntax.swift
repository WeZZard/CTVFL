//
//  CTVFLUnarySyntax.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


public protocol CTVFLUnarySyntax: CTVFLOperand {
    associatedtype Operand: CTVFLOperand
    
    var operand: Operand { get }
    
    func attributeForContainer(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute
}

extension CTVFLUnarySyntax {
    public func attributeForContainer(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        let rawOptions = options.rawValue
        
        switch site {
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
            @unknown default: fatalError()
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
            @unknown default: fatalError()
            }
        @unknown default: fatalError()
        }
    }
}

extension CTVFLUnarySyntax where Self: CTVFLAssociatedOperand, Operand: CTVFLAssociatedOperand {
    public func attributeForBeingEvaluated(at site: CTVFLSyntaxEvaluationSite, forOrientation orientation: CTVFLOrientation, withOptions options: CTVFLFormatOptions)-> CTVFLLayoutAttribute {
        return operand.attributeForBeingEvaluated(at: site, forOrientation: orientation, withOptions: options)
    }
}

#if os(iOS) || os(tvOS)
@available(iOSApplicationExtension 11.0, tvOSApplicationExtension 11.0, *)
let _rawSpacingBaselineToBaseline = CTVFLFormatOptions.spacingBaselineToBaseline.rawValue
#endif
let _rawDirectionLeftToRight = CTVFLFormatOptions.directionLeftToRight.rawValue
let _rawDirectionRightToLeft = CTVFLFormatOptions.directionRightToLeft.rawValue
