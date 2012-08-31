//
//  MathHelper.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/19/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "MathHelper.h"

@implementation MathHelper

#define ARC4RANDOM_MAX      0x100000000

// get a random number between 0~100
+(float)GetRandomPercentage
{
    return  floorf(((double)arc4random()/ARC4RANDOM_MAX)*100.0f);
}

@end
