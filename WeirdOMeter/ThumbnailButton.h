//
//  ThumbnailButton.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/27/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kThumbSide 90
#define kPadding 10

@protocol ThumbnailButtonDelegate <NSObject>

-(void)didSelectThumbnail:(id)sender;

@end

@interface ThumbnailButton : UIButton

@property (nonatomic, assign) id <ThumbnailButtonDelegate> delegate;
@property (nonatomic, assign) int userid;
@property (nonatomic, assign) float rate;
@property (nonatomic, retain) NSString *username;

-(id)initWithIndex:(int)i andData:(NSDictionary*)data;

@end
