//
//  RateMeter.m
//  WeirdOMeter
//
//  Created by rhomhazar on 11/2/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "RateMeter.h"
#import <math.h>

@implementation RateMeter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}



-(void)setNeedle:(UIImageView *)needle
{

}

-(void)setWheel:(UIImageView *)wheel
{
   
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

    CGPoint location = [[touches anyObject] locationInView:self];

    
    float dX = location.x-_needle.layer.position.x;        // distance along X
    float dY = location.y-_needle.layer.position.y;        // distance along Y
    float radians = atan2(dY, dX);          // tan = opp / adj

    float degrees = radians*360/M_PI;
    [self.delegate rotateNeedle:(degrees/-20)];//(degrees+180)/-20];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
