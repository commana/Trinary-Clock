//
//  Sinus.m
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Sinus.h"


@implementation Sinus

- (id)initWithFrame:(CGRect)frame color:(UIColor *)graphColor amplitude:(CGFloat)ampl thickness:(CGFloat)thick startValue:(CGFloat)startValue {
    if (self = [super initWithFrame:frame]) {
		color = [graphColor retain];
		amplitude = ampl;
		thickness = thick;
		initValue = startValue;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)update:(CGFloat)updateValue {
	NSLog(@"%f", updateValue);
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, thickness);
	[color set];
	
	CGFloat init = initValue;
	
	CGFloat width = rect.size.width;
	CGFloat height = rect.size.height;
	init = 2 * init + 1;
	
	CGFloat halfHeight = height / 2;
	CGFloat offsetY = halfHeight * (1 - amplitude);
	CGFloat k = 2 * M_PI / width;
	
	init *= width / 2;
	
	CGContextBeginPath(context);
	
	int iterations = (int)width / 10 + 1;
	CGPoint *points = malloc(iterations * sizeof(CGPoint));
	for (int i=0, j=0; j <= iterations; i += 10, j++) {
		CGFloat f = k * (i + init);
		CGFloat y = offsetY + amplitude * halfHeight * (1 + cos(f));
		points[j] = CGPointMake(i, y);
	}
	CGContextAddLines(context, points, iterations);
	free(points);
	
	CGContextDrawPath(context, kCGPathStroke);
}


- (void)dealloc {
    [super dealloc];
	
	[color release];
}

@end
