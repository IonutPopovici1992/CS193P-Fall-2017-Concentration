//
//  AspectRatioGrid.swift
//  GameOfSet
//
//  Created by John on 2/13/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import UIKit

// General Idea:
// start out with one row,
// keep adding rows while aspectRatio improves towards idealAspectRatio
//
// What we need:
// - ideal aspectRatio
// - number of CGRects (here for cards)
// - CGRect of superView

struct AspectRatioGrid {
    
    private var bounds: CGRect {
        didSet {
            calculateGrid()
        }
    }
    private var noOfFrames: Int {
        didSet {
            calculateGrid()
            
        }
    }
    static var idealAspectRatio: CGFloat = 0.7
    
    init(for bounds: CGRect, withNoOfFrames: Int, forIdeal aspectRatio: CGFloat = AspectRatioGrid.idealAspectRatio) {
        self.bounds = bounds
        self.noOfFrames = withNoOfFrames
        AspectRatioGrid.idealAspectRatio = aspectRatio
        calculateGrid()
    }
    
    subscript(index: Int) -> CGRect? {
        return index < cellFrames.count ? cellFrames[index] : nil
    }
    
    private struct GridDimensions: Comparable {
        static func <(lhs: AspectRatioGrid.GridDimensions, rhs: AspectRatioGrid.GridDimensions) -> Bool {
            return lhs.isCloserToIdeal(aspectRatio: rhs.aspectRatio)
        }
        
        static func == (lhs: AspectRatioGrid.GridDimensions, rhs: AspectRatioGrid.GridDimensions) -> Bool {
            return lhs.cols == rhs.cols && lhs.rows == rhs.rows
        }
        
        var cols: Int
        var rows: Int
        var frameSize: CGSize
        var aspectRatio: CGFloat {
            return frameSize.width/frameSize.height
        }
        
        func isCloserToIdeal(aspectRatio: CGFloat) -> Bool {
            return (AspectRatioGrid.idealAspectRatio - aspectRatio).abs < (AspectRatioGrid.idealAspectRatio - self.aspectRatio).abs
        }
    }
    
    private var bestGridDimensions: GridDimensions?
    private mutating func calculateGridDimensions() {
        for cols in 1...noOfFrames {
            let rows = noOfFrames % cols == 0 ? noOfFrames / cols : noOfFrames / cols + 1
            let calculatedframeDimension = GridDimensions(
                cols: cols,
                rows: rows,
                frameSize: CGSize(width: bounds.width/CGFloat(cols), height: bounds.height/CGFloat(rows))
            )
            
            if let bestFrameDimension = bestGridDimensions, bestFrameDimension > calculatedframeDimension {
                return
            } else {
                self.bestGridDimensions = calculatedframeDimension
            }
        }
        return
    }
    
    private var cellFrames: [CGRect] = []
    private mutating func calculateGrid() {
        var grid = [CGRect]()
        calculateGridDimensions()
        guard let bestGridDimensions = bestGridDimensions else {
            grid = []
            return
        }
        for row in 0..<bestGridDimensions.rows {
            for col in 0..<bestGridDimensions.cols {
                let origin = CGPoint(x: CGFloat(col) * bestGridDimensions.frameSize.width, y: CGFloat(row) * bestGridDimensions.frameSize.height)
                let rect = CGRect(origin: origin, size: bestGridDimensions.frameSize)
                grid.append(rect)
            }
        }
        self.cellFrames = grid
    }
    
}
