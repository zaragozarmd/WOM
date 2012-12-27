//
//  WeirdestViewController.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/28/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "WeirdestViewController.h"
#import "WeirdestTableViewCell.h"
#import "API.h"
#import <QuartzCore/QuartzCore.h>

@interface WeirdestViewController ()

@end

@implementation WeirdestViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)queryLikedPhotos
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"getLikedPhotos", @"command",
                                   [user objectForKey:@"userid"], @"userid", nil];
    
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json){
        if (![json objectForKey:@"error"]) {
            self.likedPhotos = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"result"]];

        }
        else{
            NSLog(@"Error queryLikedPhotos %@", [json objectForKey:@"error"]);
        }
    }];
}

-(void)queryWeirdestPics
{
 
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"getTop", @"command", nil];
    [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json){
        
        if (![json objectForKey:@"error"])
        {

            self.weirdestArr = [[NSArray alloc] initWithArray:[json objectForKey:@"result"]];
        
            self.imgArr = [[NSMutableArray alloc]initWithCapacity:[_weirdestArr count]];
        
            for (int i=0; i<[_weirdestArr count]; i++) {
                NSDictionary *item = [_weirdestArr objectAtIndex:i];
                NSNumber *photoid = [NSNumber numberWithInt:[[item objectForKey:@"photoid"] intValue]];
                NSString *user = [item objectForKey:@"username"];
            
                NSURL *imgURL = [[API sharedInstance] urlForImageWithId:photoid andUserName:user isThumb:NO];
            
                UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 291, 267)];
                [iv setImageWithURL:imgURL];
            
                [_imgArr addObject:iv];

            }
        
            [self.tableView reloadData];
        }
        else
        {
            NSLog(@"Error queryWeirdestPics %@", [json objectForKey:@"error"]);
        }
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *bgimage = [[UIImageView alloc] initWithFrame:self.tableView.frame];
    bgimage.image = [UIImage imageNamed:@"bg-plain.png"];
    
    [self.tableView setBackgroundView:bgimage];


    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!_weirdestArr) {
        [self queryLikedPhotos];
        [self queryWeirdestPics];
        
    }

}

-(void)viewWillDisappear:(BOOL)animated
{
    _weirdestArr = nil;
    _imgArr = nil;
    _likedPhotos = nil;
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (![_weirdestArr count]) {
        return 1;
    }
    else{
    return [_weirdestArr count];
    }
}


-(BOOL)checkIfLiked:(int)photoID
{
    if ([_likedPhotos count]>0) {
        for (int i=0; i<[_likedPhotos count]; i++) {
            NSDictionary *item = [_likedPhotos objectAtIndex:i];
            int photoid = [[item objectForKey:@"photoid"] intValue];
            
            if (photoID == photoid) {
                return YES;
            }
        }
    }
    
    return NO;
}

-(void)didLike:(NSNumber*)photoid
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:photoid, @"photoid",  nil];
    [_likedPhotos addObject:params];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"CustomCell";
    
    // Configure the cell...

    WeirdestTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if(cell==nil)
    {
        cell =[[WeirdestTableViewCell alloc] init];
    }
    
    [cell.activityInd startAnimating];
    
    for (UIView *subview in [cell subviews]) {
        if (subview.tag == 10) {
            [subview removeFromSuperview];
        }
    }
    
    if ([_weirdestArr count]>0)
    {
        NSDictionary *item = [_weirdestArr objectAtIndex:indexPath.row];
        NSString *user = [item objectForKey:@"username"];
        double score = [[item objectForKey:@"avgRate"] doubleValue];
        NSNumber *likes = [NSNumber numberWithInt:[[item objectForKey:@"numLikes"] intValue]];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:cell.imageView.frame];
        UIImageView *iv = [_imgArr objectAtIndex:indexPath.row];
        [imgView setImage:iv.image];
        [cell addSubview:imgView];
        
        float angle = ((score/10)/0.32) + (-26.7);
        [cell.needle setHidden:YES];
        UIImageView *n = [[UIImageView alloc] initWithFrame:cell.needle.frame];
        [n setTag:10];
        [n setImage:[UIImage imageNamed:@"needle4.png"]];
        n.layer.anchorPoint = CGPointMake(cell.needle.layer.anchorPoint.x, cell.needle.layer.anchorPoint.y*2);
        [n setTransform: CGAffineTransformMakeRotation(angle)];
        [cell addSubview:n];
        
        cell.lblUser.text = user;
        cell.lblLikes.text = [likes stringValue];
        cell.lblScore.text = [NSString stringWithFormat:@"%.1f", score];
        
        
       
        if (imgView.image) {
            [cell.activityInd stopAnimating];
        }
        
        cell.likes = likes;
        cell.score = score;
        cell.username = user;
        cell.photoid = [item objectForKey:@"photoid"];
        cell.userid = [item objectForKey:@"userid"];
        [cell likeBtnHighlight:[self checkIfLiked:[cell.photoid intValue]]];
        cell.delegate = self;
    
    }

    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
