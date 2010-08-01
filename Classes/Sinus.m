//
//  Sinus.m
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright (c) 2010 Christoph Thelen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
	initValue = updateValue;
	[self setNeedsDisplay];
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
