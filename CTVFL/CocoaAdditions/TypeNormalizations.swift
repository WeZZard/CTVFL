//
//  TypeNormalizations.swift
//  CTVFL
//
//  Created on 2019/3/28.
//


#if os(iOS) || os(tvOS)

import UIKit

public typealias CTVFLView = UIView

public typealias CTVFLPriority = UILayoutPriority

@available(iOSApplicationExtension 9.0, tvOSApplicationExtension 9.0, *)
public typealias CTVFLLayoutGuide = UILayoutGuide

#else

import AppKit

public typealias CTVFLView = NSView

public typealias CTVFLPriority = NSLayoutConstraint.Priority

@available(macOSApplicationExtension 10.11, *)
public typealias CTVFLLayoutGuide = NSLayoutGuide

#endif

public typealias CTVFLFormatOptions = NSLayoutConstraint.FormatOptions

public typealias CTVFLLayoutRelation = NSLayoutConstraint.Relation

public typealias CTVFLConstraint = NSLayoutConstraint
