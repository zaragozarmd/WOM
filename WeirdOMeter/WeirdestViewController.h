//
//  WeirdestViewController.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeirdestTableViewCell.h"

@interface WeirdestViewController : UITableViewController<WeirdestTableViewCellDelegate>

@property (nonatomic, retain) NSArray *weirdestArr;
@property (nonatomic, retain) NSMutableArray *imgArr;
@property (nonatomic, retain) NSMutableArray *likedPhotos;
@property (nonatomic, retain) NSString *username;



-(void)queryWeirdestPics;

@end
