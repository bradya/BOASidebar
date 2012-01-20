/*-
 *  BOA Sidebar
 *  
 *  Copyright 2012 Brady Archambo
 *  Created by Brady Archambo.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 *
 *  Find me on Twitter, twitter.com/bradyy
 *
 */

#import "BOAAccessoryView.h"

@implementation BOAAccessoryView

@synthesize accessoryColor = _accessoryColor, highlightedColor = _highlightedColor;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (BOAAccessoryView *)accessoryWithColor:(UIColor *)color
{
	BOAAccessoryView * accessoryView = [[BOAAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 11.0, 15.0)];
	accessoryView.accessoryColor = color;
    
	return accessoryView;
}

- (void)drawRect:(CGRect)rect
{
	// (x,y) is the tip of the arrow
	CGFloat x = CGRectGetMaxX(self.bounds)-3.0;;
	CGFloat y = CGRectGetMidY(self.bounds);
	const CGFloat R = 4.5;
	CGContextRef ctxt = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(ctxt, x-R, y-R);
	CGContextAddLineToPoint(ctxt, x, y);
	CGContextAddLineToPoint(ctxt, x-R, y+R);
	CGContextSetLineCap(ctxt, kCGLineCapSquare);
	CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
	CGContextSetLineWidth(ctxt, 3);
    
	if (self.highlighted)
	{
		[self.highlightedColor setStroke];
	}
	else
	{
		[self.accessoryColor setStroke];
	}
    
	CGContextStrokePath(ctxt);
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
    
	[self setNeedsDisplay];
}

- (UIColor *)accessoryColor
{
	if (!_accessoryColor)
	{
		return [UIColor blackColor];
	}
    
	return _accessoryColor;
}

- (UIColor *)highlightedColor
{
	if (!_highlightedColor)
	{
		return [UIColor whiteColor];
	}
    
	return _highlightedColor;
}

@end
