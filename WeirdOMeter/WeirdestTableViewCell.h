//
//  WeirdestTableViewCell.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeirdestTableViewCellDelegate <NSObject>

-(void)didLike:(NSNumber *)photoid;

@end

@interface WeirdestTableViewCell : UITableViewCell

@property (nonatomic, assign) id <WeirdestTableViewCellDelegate> delegate;

@property (nonatomic, assign) double score;
@property (nonatomic, retain) NSNumber *likes;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSNumber *photoid;
@property (nonatomic, retain) NSNumber *userid;
@property (nonatomic, assign) BOOL isInit;
@property (nonatomic, assign) BOOL isLiked;

@property (nonatomic, retain) IBOutlet UILabel *lblUser;
@property (nonatomic, retain) IBOutlet UILabel *lblLikes;
@property (nonatomic, retain) IBOutlet UILabel *lblScore;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityInd;
@property (nonatomic, retain) IBOutlet UIButton *btnLike;
@property (nonatomic, retain) IBOutlet UIImageView *needle;


-(IBAction)like:(UIButton*)sender;
-(void)likeBtnHighlight:(BOOL)isHighlighted;
-(void)adjustNeedle:(float)angle;

@end
