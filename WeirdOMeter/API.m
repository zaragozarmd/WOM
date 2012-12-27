//
//  API.m
//  WeirdOMeter
//
//  Created by rhomhazar on 10/21/12.
//  Copyright (c) 2012 rhomhazar. All rights reserved.
//

#import "API.h"
#define kAPIHost @"http://rhomhazar.comuf.com"
#define kAPIPath @"weirdometer/"

@implementation API

+(API*)sharedInstance
{
    static API *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIHost]];
    });
    
    return sharedInstance;
}

-(API*)init
{
    self = [super init];
    
    if (self != nil) {
        _user = nil;
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

-(BOOL)isAuthorized
{
    return [[_user objectForKey:@"userid"] intValue]>0;
}

-(void)commandWithParams:(NSMutableDictionary *)params onCompletion:(JSONResponseBlock)completionBlock
{
    NSData *uploadFile = nil;
    if ([params objectForKey:@"file"]) {
        uploadFile = (NSData*) [params objectForKey:@"file"];
        [params removeObjectForKey:@"file"];
    }


    NSMutableURLRequest *apiRequest = [self multipartFormRequestWithMethod:@"POST" path:kAPIPath parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData>formData){
        //Attach file if needed
        
        if (uploadFile) {
            [formData appendPartWithFileData:uploadFile name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        }
    }];
    
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:apiRequest];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        completionBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"API %@", error);
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
    }];
    
    [operation start];
    
}

-(NSURL*)urlForImageWithId:(NSNumber *)IdPhoto andUserName:(NSString*)username isThumb:(BOOL)isThumb
{
        
    NSString* urlString = [NSString stringWithFormat:@"%@/%@Uploads/%@/%@%@.jpg",
                           kAPIHost, kAPIPath, username, IdPhoto, (isThumb)?@"-thumb":@""
                           ];
    return [NSURL URLWithString:urlString];
}

@end
