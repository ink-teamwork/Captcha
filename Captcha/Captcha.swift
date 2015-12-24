//
//  Captcha.swift
//  Captcha
//
//  Created by zhaokai on 15/12/24.
//  Copyright © 2015年 赵凯. All rights reserved.
//

import UIKit

class Captcha: UIView {

    let changeArray = ["0","1","2","3","4","5","6","7","8","9"]
    var changeString = ""
    let changeCount = 5
    
    let lineCount = 6
    let lineWidth = 1.0 as CGFloat
    var fontSize:CGFloat! = UIFont.systemFontSize()
    override init(frame: CGRect){
        super.init(frame: frame)
        self.frame = frame
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = true;
        self.backgroundColor = self.getColor();
        self.changeCaptcha()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changeCaptcha() ->Void {
        self.changeString = ""
        for _  in 1...changeCount{
            let index = NSInteger.init(arc4random()) % changeArray.count
            changeString += changeArray[index]
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.changeCaptcha()
        self.setNeedsDisplay()
    }

    override func drawRect(rect: CGRect){
        super.drawRect(rect)
        self.backgroundColor = self.getColor()

        let cSize = CGSize.init(width: fontSize, height: fontSize)

        let width = rect.size.width / CGFloat.init(changeCount)  - cSize.width;
        let height = rect.size.height - cSize.height;
        
        var point:CGPoint

        var pX:CGFloat, pY:CGFloat

        var i = 0;
        for str in changeString.unicodeScalars {
            pX = CGFloat.init(arc4random()) % width + rect.width/CGFloat.init(changeCount) * CGFloat.init(i);
            pY = CGFloat.init(arc4random()) % height;
            point = CGPointMake(pX, pY);
            let text:NSString = String.init(str)
            text.drawAtPoint(point, withAttributes: nil)
            i++
        }

        let context = UIGraphicsGetCurrentContext()

        CGContextSetLineWidth(context, lineWidth);

        for(var i = 0; i < lineCount; i++)
        {

            CGContextSetStrokeColorWithColor(context, self.getColor().CGColor)

            pX = CGFloat.init(arc4random()) % rect.size.width
            pY = CGFloat.init(arc4random()) % rect.size.height;
            CGContextMoveToPoint(context, pX, pY);

            pX = CGFloat.init(arc4random()) % rect.size.width;
            pY = CGFloat.init(arc4random()) % rect.size.height;
            CGContextAddLineToPoint(context, pX, pY);

            CGContextStrokePath(context);
        }
        
    }
    
    func getColor() -> UIColor{
        return UIColor.init(colorLiteralRed: Float.init(arc4random()%256)/256.0, green: Float.init(arc4random()%256)/256.0, blue: Float.init(arc4random()%256)/256.0, alpha: 1.0)
    }
}
