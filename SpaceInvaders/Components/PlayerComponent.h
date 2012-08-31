//
//  PlayerComponent.h
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"

@interface PlayerComponent : Component
{
    float m_movementMultiplier;
}

-(id)initWithData:(NSDictionary*)componentData;
-(void)update:(float)dt;

@end


