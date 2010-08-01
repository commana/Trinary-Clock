//
//  Sinus.h
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright 2010 Christoph Thelen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Sinus : UIView {
	UIColor *color;
	CGFloat amplitude;
	CGFloat thickness;
	CGFloat initValue;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)graphColor amplitude:(CGFloat)ampl thickness:(CGFloat)thick startValue:(CGFloat)startValue;

- (void)update:(CGFloat)updateValue;

@end
