//
//  PlayerComponent.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "PlayerComponent.h"
#import "InputManager.h"
#import "DrawComponent.h"
#import "Instance.h"
#import "AttackComponent.h"
#import "DataHelper.h"
#import "SceneManager.h"

@implementation PlayerComponent

-(id)init
{
    if(!(self = [super init]))
        return nil;
    m_type = eComponent_Player;
    return self;
}

-(id)initWithData:(NSDictionary*)componentData
{
    self = [self init];
    
    m_data = componentData;
     if([componentData objectForKey:@"MovementMultiplier"])
        m_movementMultiplier = [[componentData objectForKey:@"MovementMultiplier"] floatValue];
    else {
        NSDictionary* defaultSetting = [DataHelper ReadPlist:@"PlayerComponent"];
        m_movementMultiplier = [[defaultSetting objectForKey:@"DefaultMovementMultiplier"] floatValue];
    }
    
    return self;
}

-(void)update:(float)dt
{
    //update player control
    float speedX = [InputManager sharedInputManager].m_leftJoystick.stickPosition.x * m_movementMultiplier;
    
    Instance* player = (Instance*)m_owner;
    DrawComponent* drawComp = (DrawComponent*)[player GetComponent:eComponent_Draw];
    if(drawComp)
    {
        CGPoint pos = [drawComp GetPosition];
        pos = CGPointMake(pos.x + speedX, pos.y);
        if(pos.x < 0)
            pos.x = 0;
        if(pos.x > SCREEN_WIDTH)
            pos.x = SCREEN_WIDTH;
        [drawComp SetPosition:pos];
    }
    
    if( [InputManager sharedInputManager].m_rightButton)
    {
        
        bool pressed = [InputManager sharedInputManager].m_rightButton.active;
        if(pressed)
        {
            //shoot
            Instance* player = (Instance*)m_owner;
            AttackComponent* attachComp = (AttackComponent*)[player GetComponent:eComponent_Attack];
            if(attachComp)
                [attachComp shoot];
        }
    }
    
}

@end
