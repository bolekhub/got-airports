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
/**
 *  Used by subclasses to obtain flights endpoint
 *
 *  @return string object containint the endpoint of flights
 */
+(NSString *)flightStringUrl;


/**
 *  Used by subclasses to obtain exchange endpoint
 *
 *  @return string object containint the endpoint of exchange
 */
+(NSString *)xchangeStringUrl;

@end
