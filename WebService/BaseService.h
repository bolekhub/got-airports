//
//  BaseService.h
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FlightsServiceCompletion)(NSArray *response, NSError *error);
typedef void(^CurrencyServiceCompletion)(NSNumber *rate, NSError *error);


@interface BaseService : NSObject
+(NSString *)flightStringUrl;
+(NSString *)xchangeStringUrl;

@end
