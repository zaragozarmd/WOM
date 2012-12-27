//
//  RateMeter.h
//  WeirdOMeter
//
//  Created by rhomhazar on 11/2/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol RateMeterDelegate <NSObject>

-(void)rotateNeedle:(float)angle;

@end

@interface RateMeter : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, retain) id <RateMeterDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *needle;
@property (nonatomic, retain) IBOutlet UIImageView *wheel;

@property (nonatomic, assign) float deltaAngle;
@property (nonatomic, assign) CGAffineTransform startTransform;
@end
