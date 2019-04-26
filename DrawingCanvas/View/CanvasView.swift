//
//  CanvasView.swift
//  DrawingCanvas
//
//  Created by Ashis Laha on 1/16/19.
//  Copyright © 2019 Ashis Laha. All rights reserved.
//

import UIKit

struct Line {
    var points: [CGPoint]
    let strokeColor: UIColor
    let strokeWidth: CGFloat
}

class CanvasView: UIView {

    // private properties
    private var lines: [Line] = []
    private var strokeColor: UIColor = .red
    private var strokeWidth: CGFloat = 5.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for line in lines {
            context.setStrokeColor(line.strokeColor.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            
            for (index, point) in line.points.enumerated() {
                if index == 0 { // starting point
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: self) else { return }
        let newLine = Line(points: [point], strokeColor: strokeColor, strokeWidth: strokeWidth)
        lines.append(newLine)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // update the lines last item
        guard var lastLine = lines.popLast(), let point = touches.first?.location(in: self) else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
    
    // public functionlity
    public func setStrokeWidth(_ width: CGFloat) {
        strokeWidth = width
    }
    public func setStrokeColor(_ color: UIColor) {
        strokeColor = color
    }
    public func clearAll() {
        lines.removeAll()
        setNeedsDisplay()
    }
    public func undo() {
        guard !lines.isEmpty else { return }
        lines.removeLast()
        setNeedsDisplay()
    }
}
