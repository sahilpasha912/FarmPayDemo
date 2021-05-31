//
//  UtilityFunctions.swift
//  FarmPayDemo
//
//  Created by iPHTech20 on 23/05/21.
//

import Foundation
import UIKit


/// To make a curve at extreme point of any view
/// - Parameter baseView: View in which curve has to be formed
/// - Parameter borderColor: border color for the curve line
/// - Parameter btnView: Optional, if want to set extra curve at middle for showing view as above curve
/// - Parameter margin: curve starting distance from left and curve end distance right
/// - Parameter curveAtTop: if want to make an opposite curve, down curve
/// - Parameter curveRadius: radius of curve.
func setfooterCurve(baseView: UIView, borderColor: UIColor, btnView:UIView?, margin:CGFloat = 0, curveAtTop:Bool = false, curveRadius:CGFloat = 20.0, curveTopBottom:Bool = false){
    baseView.layoutIfNeeded()
    var path = UIBezierPath()
    if curveTopBottom {
        path = setTopCornerWithreverseBottomCorner(baseView: baseView, margin: margin, curveRadius: curveRadius)
    } else {
        if curveAtTop{
            path = getConcaveCurve(baseView: baseView,  btnView:btnView, margin: margin, curveRadius: curveRadius)
            path.addLine(to: CGPoint(x: baseView.frame.width , y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }else{
            path = getTopConvexCurve(baseView: baseView,  btnView:btnView, margin: margin, curveRadius: curveRadius)
            path.addLine(to: CGPoint(x: baseView.frame.width , y: baseView.frame.height))
            path.addLine(to: CGPoint(x: 0, y: baseView.frame.height))
        }
    }
    
    path.lineWidth = 1.0
    path.close()
    
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    baseView.layer.mask = mask
    baseView.layer.masksToBounds = true
    // Check previously added border layer
    for layer in baseView.layer.sublayers ?? [CAShapeLayer()]{
        if layer.name == "footer_border"{
            layer.removeFromSuperlayer()
        }
    }
    
    // Add border layer
    let borderLayer = CAShapeLayer()
    if curveAtTop{
        borderLayer.path = getConcaveCurve(baseView: baseView, btnView: btnView, margin: margin, curveRadius: curveRadius).cgPath
    }else{
        borderLayer.path = getTopConvexCurve(baseView: baseView, btnView: btnView, margin: margin, curveRadius: curveRadius).cgPath
    }
    
    borderLayer.fillColor = UIColor.clear.cgColor
    borderLayer.strokeColor = borderColor.cgColor
    borderLayer.lineWidth = 0.6
    borderLayer.frame = baseView.bounds
    borderLayer.name = "footer_border"
    baseView.layer.addSublayer(borderLayer)
}

private func getTopConvexCurve(baseView: UIView,  btnView:UIView?, margin: CGFloat = 0, curveRadius:CGFloat = 20.0) -> UIBezierPath{
    let path = UIBezierPath()
    if margin != 0{
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: margin, y: 0))
    }else{
        path.move(to: CGPoint(x: 0, y: 0))
    }
    path.addQuadCurve(to: CGPoint(x: curveRadius + margin, y: curveRadius), controlPoint: CGPoint(x: margin, y: curveRadius))
    if btnView != nil{
        path.addLine(to: CGPoint(x: baseView.bounds.width/2 - btnView!.bounds.width/2 - curveRadius - 10, y: baseView.bounds.minY + curveRadius))
        path.addCurve(to: CGPoint(x: baseView.bounds.width/2 - btnView!.bounds.width/2 + btnView!.bounds.height/2, y: baseView.bounds.minY + curveRadius + 20), controlPoint1: CGPoint(x: baseView.bounds.width/2 - btnView!.bounds.width/2 + 20, y: baseView.bounds.minY + curveRadius), controlPoint2: CGPoint(x: baseView.bounds.width/2 - btnView!.bounds.width/1.4, y: baseView.bounds.minY + curveRadius + 15))
        path.addLine(to: CGPoint(x: baseView.bounds.width/2 + btnView!.bounds.width/2 - btnView!.bounds.height/2, y: baseView.bounds.minY + curveRadius + 20))
        path.addCurve(to: CGPoint(x: baseView.bounds.width/2 + btnView!.bounds.width/2 + curveRadius + 10, y: baseView.bounds.minY + curveRadius), controlPoint1: CGPoint(x: baseView.bounds.width/2 + btnView!.bounds.width/1.4, y: baseView.bounds.minY + curveRadius + 15), controlPoint2: CGPoint(x: baseView.bounds.width/2 + btnView!.bounds.width/2 - 15, y: baseView.bounds.minY + curveRadius))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width - curveRadius - margin, y: baseView.bounds.minY + curveRadius))
    }else{
        path.addLine(to: CGPoint(x: baseView.frame.width - curveRadius - margin, y: curveRadius))
    }
    path.addQuadCurve(to: CGPoint(x: baseView.frame.width - margin, y: 0), controlPoint: CGPoint(x: baseView.frame.width - margin, y: curveRadius))
    if margin != 0{
        path.addLine(to: CGPoint(x: baseView.frame.width, y: 0))
    }
    return path
}



private func getConcaveCurve(baseView: UIView,  btnView:UIView?, margin:CGFloat = 0, curveRadius:CGFloat = 20.0) -> UIBezierPath{
    let path = UIBezierPath()
    if margin != 0{
        path.move(to: CGPoint(x: 0, y: baseView.bounds.height))
        path.addLine(to: CGPoint(x: margin, y: baseView.bounds.height))
    }else{
        path.move(to: CGPoint(x: 0, y: baseView.bounds.height))
    }
    
    path.addQuadCurve(to: CGPoint(x: curveRadius + margin, y: baseView.bounds.height - curveRadius), controlPoint: CGPoint(x: margin, y: baseView.bounds.height - curveRadius))
    path.addLine(to: CGPoint(x: baseView.frame.width - curveRadius - margin, y:baseView.bounds.height - curveRadius))
    path.addQuadCurve(to: CGPoint(x: baseView.frame.width - margin, y: baseView.bounds.height), controlPoint: CGPoint(x: baseView.frame.width - margin, y: baseView.bounds.height - curveRadius))
    if margin != 0{
        path.addLine(to: CGPoint(x: baseView.frame.width, y: baseView.bounds.height))
    }
    return path
}


func setTopCornerWithreverseBottomCorner(baseView: UIView, margin:CGFloat = 0.0, curveRadius: CGFloat = 20.0)  -> UIBezierPath{
    let path = UIBezierPath()
//    path.move(to: CGPoint(x: 0, y: baseView.bounds.height))
    if margin != 0{
        path.move(to: CGPoint(x: 0, y: baseView.bounds.height))
        path.addLine(to: CGPoint(x: margin, y: baseView.bounds.height))
    }else{
        path.move(to: CGPoint(x: 0, y: baseView.bounds.height))
    }
    path.addQuadCurve(to: CGPoint(x: curveRadius + margin, y: baseView.bounds.height - curveRadius), controlPoint: CGPoint(x: margin, y: baseView.bounds.height - curveRadius))
    path.addLine(to: CGPoint(x: baseView.frame.width - curveRadius - margin, y:baseView.bounds.height - curveRadius))
    path.addQuadCurve(to: CGPoint(x: baseView.frame.width - margin, y: baseView.bounds.height), controlPoint: CGPoint(x: baseView.frame.width - margin, y: baseView.bounds.height - curveRadius))
    path.addLine(to: CGPoint(x: baseView.frame.width, y: baseView.frame.height))
    path.addLine(to: CGPoint(x: baseView.frame.width, y: curveRadius))
    path.addLine(to: CGPoint(x: baseView.frame.width - margin, y: curveRadius))
    path.addQuadCurve(to: CGPoint(x:  baseView.frame.width - curveRadius - margin, y: 0), controlPoint: CGPoint(x: baseView.frame.width - margin, y: 0))
    path.addLine(to: CGPoint(x: curveRadius + margin, y: 0))
    path.addQuadCurve(to: CGPoint(x: margin, y: curveRadius), controlPoint: CGPoint(x: margin, y: 0))
    path.addLine(to: CGPoint(x: 0, y: curveRadius))
    return path
}

