//
//  Sinus.h
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Sinus : UIView {
	UIColor *color;
	CGFloat amplitude;
	int thickness;
}

- (id)initWithFrame:(CGRect)frame color:(UIColor *)graphColor amplitude:(CGFloat)ampl thickness:(int)thick;

@end
