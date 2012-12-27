//
//  ThumbnailButton.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/27/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "ThumbnailButton.h"
#import "API.h"


@implementation ThumbnailButton

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithIndex:(int)i andData:(NSDictionary *)data
{
    self = [super init];
    
    //initialize
    self.tag = [[data objectForKey:@"photoid"] intValue];
    self.userid = [[data objectForKey:@"userid"] intValue];
    self.username = [data objectForKey:@"username"];

    int row = i/3;
    int col = i % 3;
    
    self.frame = CGRectMake(1.5*kPadding+col*(kThumbSide+kPadding), 1.5*kPadding+row*(kThumbSide+kPadding), kThumbSide, kThumbSide);
    self.backgroundColor = [UIColor grayColor];
    
    //add the photo caption
    UILabel* caption = [[UILabel alloc] initWithFrame:
                        CGRectMake(0, kThumbSide-16, kThumbSide, 16)
                        ];
    caption.backgroundColor = [UIColor blackColor];
    caption.textColor = [UIColor whiteColor];
    caption.textAlignment = UITextAlignmentCenter;
    caption.font = [UIFont systemFontOfSize:12];
    caption.text = [NSString stringWithFormat:@"@%@",[data objectForKey:@"username"]];
    //[self addSubview: caption];
    
    //add touch event
    [self addTarget:delegate action:@selector(didSelectThumbnail:) forControlEvents:UIControlEventTouchUpInside];
   
    
    //load the image
    API* api = [API sharedInstance];
    int photoid = [[data objectForKey:@"photoid"] intValue];
    
    
    NSURL* imageURL = [api urlForImageWithId:[NSNumber numberWithInt: photoid] andUserName:[data objectForKey:@"username"] isThumb:YES];
    
    AFImageRequestOperation* imageOperation =
    [AFImageRequestOperation imageRequestOperationWithRequest: [NSURLRequest requestWithURL:imageURL]
                                                      success:^(UIImage *image) {
                                                          //create an image view, add it to the view
                                                          UIImageView* thumbView = [[UIImageView alloc] initWithImage: image];
                                                          thumbView.frame = CGRectMake(0,0,90,90);
                                                          thumbView.contentMode = UIViewContentModeScaleAspectFit;
                                                          [self insertSubview: thumbView belowSubview: caption];
                                                      }];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue addOperation:imageOperation];
    
    return self;
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
