//
//  API.h
//  WeirdOMeter
//
//  Created by rhomhazar on 10/21/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

typedef void (^JSONResponseBlock)(NSDictionary *json);

@interface API : AFHTTPClient

@property (strong, nonatomic) NSDictionary *user;

+(API*)sharedInstance;

-(BOOL)isAuthorized;
-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(NSURL*)urlForImageWithId:(NSNumber *)IdPhoto andUserName:(NSString*)username isThumb:(BOOL)isThumb;


@end
