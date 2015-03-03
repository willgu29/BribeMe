//
//  Converter.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "Converter.h"

@implementation Converter

+(NSString *)getCategoryFromIndex:(int)index
{
    if (index == 0)
    {
        return @"Featured";
    }
    else if (index == 1)
    {
        return @"Dining";
    }
    else if (index == 2)
    {
        return @"Nightlife";
    }
    else if (index == 3)
    {
        return @"Shopping";
    }
    else if (index == 4)
    {
        return @"Services";
    }
    return @"NONESET";
    
}

@end
