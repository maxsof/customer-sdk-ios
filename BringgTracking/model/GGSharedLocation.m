//
//  GGSharedLocation.m
//  BringgTracking
//
//  Created by Matan on 6/25/15.
//  Copyright (c) 2015 Matan Poreh. All rights reserved.
//

#import "GGSharedLocation.h"
#import "BringgGlobals.h"
#import "GGBringgUtils.h"

@implementation GGSharedLocation

@synthesize locationUUID,orderUUID,waypointID,eta,driver,rating,trackingURL, orderID, ratingURL;


-(nullable instancetype)initWithData:(NSDictionary * _Nullable)data{
    
    if (self = [super init]) {
        //
        locationUUID = [GGBringgUtils stringFromJSON:[data objectForKey:PARAM_UUID] defaultTo:nil];
        orderUUID = [GGBringgUtils stringFromJSON:[data objectForKey:PARAM_ORDER_UUID] defaultTo:nil];
        orderID = [GGBringgUtils integerFromJSON:[data objectForKey:@"task_id"] defaultTo:0];
        waypointID = [GGBringgUtils integerFromJSON:[data objectForKey:PARAM_WAY_POINT_ID] defaultTo:0];
        eta = [GGBringgUtils stringFromJSON:[data objectForKey:PARAM_ETA] defaultTo:nil];
        
        trackingURL = [GGBringgUtils stringFromJSON:data[@"url"] defaultTo:nil];
        ratingURL = [GGBringgUtils stringFromJSON:data[PARAM_RATING_URL] defaultTo:nil];
        
        rating = [[GGRating alloc] initWithRatingToken:[GGBringgUtils stringFromJSON:[data objectForKey:PARAM_RATING_TOKEN] defaultTo:@""]];
        
        driver = [[GGDriver alloc] initWithID:[GGBringgUtils integerFromJSON:data[@"user_id"] defaultTo:0]
                                         uuid:[GGBringgUtils stringFromJSON:data[PARAM_DRIVER_UUID] defaultTo:[GGBringgUtils stringFromJSON:data[PARAM_UUID] defaultTo:nil]]
                                         name:[GGBringgUtils stringFromJSON:data[PARAM_DRIVER_NAME] defaultTo:[GGBringgUtils stringFromJSON:data[PARAM_NAME] defaultTo:nil]]
                                        phone:[GGBringgUtils stringFromJSON:data[PARAM_DRIVER_PHONE] defaultTo:[GGBringgUtils stringFromJSON:data[PARAM_DRIVER_PHONE2] defaultTo:nil]]
                                     latitude:[GGBringgUtils doubleFromJSON:data[PARAM_CURRENT_LAT] defaultTo:[GGBringgUtils doubleFromJSON:data[PARAM_LAT] defaultTo:0]]
                                    longitude:[GGBringgUtils doubleFromJSON:data[PARAM_CURRENT_LNG] defaultTo:[GGBringgUtils doubleFromJSON:data[PARAM_LNG] defaultTo:0]]
                                     activity:(int)[GGBringgUtils integerFromJSON:data[PARAM_ACTIVITY] defaultTo:[GGBringgUtils integerFromJSON:data[PARAM_DRIVER_ACTIVITY] defaultTo:0]]
                                averageRating:[GGBringgUtils doubleFromJSON:data[PARAM_DRIVER_AVG_RATING_IN_SHARED_LOCATION] defaultTo:[GGBringgUtils doubleFromJSON:data[PARAM_DRIVER_AVG_RATING] defaultTo:-1]]
                                  ratingToken:[GGBringgUtils stringFromJSON:data[PARAM_RATING_TOKEN] defaultTo:nil]
                                    ratingURL:[GGBringgUtils stringFromJSON:data[PARAM_RATING_URL] defaultTo:nil]
                                     imageURL:[data objectForKey:PARAM_DRIVER_IMAGE_URL] ? [data objectForKey:PARAM_DRIVER_IMAGE_URL] : [data objectForKey:PARAM_DRIVER_IMAGE_URL2]
                  ];
        
    }
    
    return self;
    
}

//MARK: NSCoding
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [self init]) {
        
        self.locationUUID   = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyUUID];
        self.orderUUID      = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyOrderUUID];
        self.eta            = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyETA];
        self.trackingURL    = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyTrackingURL];
        self.ratingURL      = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyRatingURL];
        
        self.driver         = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyDriver];
        self.rating         = [aDecoder decodeObjectForKey:GGSharedLocationStoreKeyRating];
        
        self.orderID        = [aDecoder decodeIntegerForKey:GGSharedLocationStoreKeyOrderID];
        self.waypointID     = [aDecoder decodeIntegerForKey:GGSharedLocationStoreKeyWaypointID];
        
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.locationUUID forKey:GGSharedLocationStoreKeyUUID];
    [aCoder encodeObject:self.orderUUID forKey:GGSharedLocationStoreKeyOrderUUID];
    [aCoder encodeObject:self.eta forKey:GGSharedLocationStoreKeyETA];
    [aCoder encodeObject:self.trackingURL forKey:GGSharedLocationStoreKeyTrackingURL];
    [aCoder encodeObject:self.ratingURL forKey:GGSharedLocationStoreKeyRatingURL];
    
    [aCoder encodeObject:self.driver forKey:GGSharedLocationStoreKeyDriver];
    [aCoder encodeObject:self.rating forKey:GGSharedLocationStoreKeyRating];
    
    [aCoder encodeInteger:self.orderID forKey:GGSharedLocationStoreKeyOrderID];
    [aCoder encodeInteger:self.waypointID forKey:GGSharedLocationStoreKeyWaypointID];
    
}
@end
