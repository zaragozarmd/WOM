//
//  WeirdestTableViewCell.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "WeirdestTableViewCell.h"
#import "API.h"

@implementation WeirdestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)adjustNeedle:(float)angle
{
//            cell.needle.layer.anchorPoint = CGPointMake(cell.needle.layer.anchorPoint.x, cell.needle.layer.anchorPoint.y*2);
//            [self.needle setTransform: CGAffineTransformMakeRotation(angle)];
//    self.needle.frame = CGRectMake(_needle.frame.origin.x, _needle.frame.origin.y, 14, 58);
    self.needle.transform = CGAffineTransformMakeRotation(angle);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)likeBtnHighlight:(BOOL)isHighlighted
{
    [self.btnLike setImage:[UIImage imageNamed:@"isLiked.png"] forState:UIControlStateDisabled];
    [_btnLike setEnabled:!isHighlighted];
}

-(IBAction)like:(UIButton*)sender
{

    NSUserDefaults *userDefs = [NSUserDefaults standardUserDefaults];
    
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"like", @"command",
                                       [userDefs objectForKey:@"userid"], @"userid",
                                       _photoid, @"photoid", nil];
        
        [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json)
         {
             if (![json objectForKey:@"error"]) {
                 [self likeBtnHighlight:YES];
                 [_delegate didLike:_photoid];
             }
             else{
                 NSLog(@"error %@", [json objectForKey:@"error"]);
             }
         }];

}



@end
