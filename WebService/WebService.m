//
//  WebService.m
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "WebService.h"
#import <UIKit/UIKit.h>
static const WebService *_instance  = nil;


@interface WebService ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLSession *session;


@end

@implementation WebService


- (instancetype)init
{
    self = [super init];
    if (self) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    return self;
}

+(id)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (void)getDragonFlightsWithPredicate:(NSPredicate *)predicate completion:(FlightsServiceCompletion)completion{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:[WebService flightStringUrl]] ];
    request.HTTPMethod = @"GET";
    self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
           // dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                if (!error && data) {
                    NSError *serializationError = nil;
                    id result = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&serializationError];
                    if (serializationError == nil) {
                        completion(result[@"results"], nil);
                    }else{
                        completion(nil, serializationError);
                    }
                }else if (error){
                    completion(nil, error);
                }

            //});
        }];
    [self.dataTask resume];
}

- (void)getExchangeRateFromCurrency:(NSString *)fromCurrency toCurrency:(NSString *)toCurrency completion:(CurrencyServiceCompletion)completion{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    NSString *params = [NSString stringWithFormat:@"?from=%@&to=%@",
                        fromCurrency,
                        toCurrency];
    
    NSURL *xchangeUrl = [NSURL URLWithString:[WebService xchangeStringUrl]];
    
    NSURL *finalUrl = [NSURL URLWithString:params relativeToURL:xchangeUrl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:finalUrl ];
    
    request.HTTPMethod = @"GET";
    self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (!error && data) {
            NSError *serializationError = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&serializationError];
            if (serializationError == nil) {
                NSNumber *xchangeRate = [NSNumber numberWithDouble: [result[@"exchangeRate"] doubleValue]] ;
                completion(xchangeRate, nil);
            }else{
                completion(nil, serializationError);
            }
        }else if (error){
            completion(nil, error);
        }
        
        //});
    }];
    [self.dataTask resume];


    
}

@end
