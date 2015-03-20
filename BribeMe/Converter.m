//
//  Converter.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "Converter.h"
#import "Constants.h"

@implementation Converter

+(NSString *)getCategoryFromIndex:(int)index
{
    if (index == MYBRIBES)
    {
        return @"My Bribes";
    }
    else if (index == FEATURED)
    {
        return @"Featured";
    }
    else if (index == DINING)
    {
        return @"Dining";
    }
    else if (index == NIGHTLIFE)
    {
        return @"Nightlife";
    }
    else if (index == SHOPPING)
    {
        return @"Shopping";
    }
    else if (index == SERVICES)
    {
        return @"Services";
    }
    return @"NONESET";
    
}

+(NSString *)getCategoryKeyFromIndex:(int)index
{
    if (index == MYBRIBES)
    {
        
    }
    else if (index == FEATURED)
    {
        return @"featured";
    }
    else if (index == DINING)
    {
        return @"dinning";
    }
    else if (index == NIGHTLIFE)
    {
        return @"nightlife";
    }
    else if (index == SHOPPING)
    {
        return @"shopping";
    }
    else if (index == SERVICES)
    {
        return @"services";
    }
    return @"NONESET";
    
}

@end
