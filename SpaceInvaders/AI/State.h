//
//  State.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Instance.h"

@interface State : NSObject
{
    
}

-(void)enter;
-(void)exit;
-(void)update:(Instance*)owner;

@end
