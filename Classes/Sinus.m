//
//  Sinus.m
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sinus.h"


@implementation Sinus

- (id)initWithFrame:(CGRect)frame color:(UIColor *)graphColor amplitude:(CGFloat)ampl thickness:(int)thick {
    if (self = [super initWithFrame:frame]) {
		color = [graphColor retain];
		amplitude = ampl;
		thickness = thick;
		self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(context, 0, 0);
	[color set];
	
	CGFloat confInit = 1; // ???
	
	CGFloat width = rect.size.width;
	CGFloat height = rect.size.height;
	CGFloat init = 2 * confInit + 1;
	
	CGFloat halfHeight = height / 2;
	CGFloat offsetY = halfHeight * (1 - amplitude);
	CGFloat k = 2 * M_PI / width;
	
	init *= width / 2;
	
	for (int i=0; i < width; i += 10) {
		CGFloat f = k * (i + init);
		CGFloat y = offsetY + amplitude * halfHeight * (1 + cos(f));
		CGContextAddLineToPoint(context, i, y);
	}
}


- (void)dealloc {
    [super dealloc];
	
	[color release];
}

@end
