//
//  AIComponent.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/4/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "AIComponent.h"
#import "SceneManager.h"
#import "InstanceManager.h"
#import "Events.h"
#import "DataHelper.h"

@implementation AIComponent

@synthesize m_stateMachine, m_speed, m_direction, m_stepDownDist;
@synthesize m_dashSpeed, m_dashDirection, m_canDash, m_dashRange;

-(id)init
{
    if(!(self = [super init]))
        return nil;
    
    m_type = eComponent_AI;

    return self;
}

-(id)initWithData:(NSDictionary*)componentData
{
    self = [self init];
    
    m_canDash = false;
    
    NSDictionary* defaultAIComponent = [DataHelper ReadPlist:@"AIComponent"];
    m_data = componentData;
    
    float directionX = 0;
    float directionY = 0;
    if([componentData objectForKey:@"DirectionX"] && [componentData objectForKey:@"DirectionY"])
    {
        directionX = [[componentData objectForKey:@"DirectionX"] floatValue];
        directionY = [[componentData objectForKey:@"DirectionY"] floatValue];
    }else {
        directionX = [[defaultAIComponent objectForKey:@"DefaultDirectionX"] floatValue];
        directionY = [[defaultAIComponent objectForKey:@"DefaultDirectionY"] floatValue];
    }
    m_direction = CGPointMake(directionX, directionY);
    
    if ([componentData objectForKey:@"Speed"]) {
        m_speed = [[componentData objectForKey:@"Speed"] floatValue];
    }else {
        m_speed = [[defaultAIComponent objectForKey:@"DefaultSpeed"] floatValue];
    }
    
    if ([componentData objectForKey:@"StepDownDist"]) {
        m_stepDownDist = [[componentData objectForKey:@"StepDownDist"]floatValue];
    }else {
        m_stepDownDist = [[defaultAIComponent objectForKey:@"DefaultStepDownDist"] floatValue];
    }
    
    if([componentData objectForKey:@"CanDash"])
    {
        m_canDash = [[componentData objectForKey:@"CanDash"] boolValue];
    }
    
    if([componentData objectForKey:@"DashSpeed"])
    {
        m_dashSpeed = [[componentData objectForKey:@"DashSpeed"] floatValue];
    }else {
        m_dashSpeed = [[defaultAIComponent objectForKey:@"DefaultDashSpeed"] floatValue];
    }
    
    if([componentData objectForKey:@"DashRange"])
    {
        m_dashRange = [[componentData objectForKey:@"DashRange"] floatValue];
    }else {
        m_dashRange = [[defaultAIComponent objectForKey:@"DefaultDashRange"] floatValue];
    }
    
    float dashDirectionX = 0;
    float dashDirectionY = 0;
    if([componentData objectForKey:@"DashDirectionX"] &&[componentData objectForKey:@"DashDirectionY"])
    {
        dashDirectionX = [[componentData objectForKey:@"DashDirectionX"] floatValue];
        dashDirectionY = [[componentData objectForKey:@"DashDirectionY"] floatValue];
    }else {
        dashDirectionX = [[defaultAIComponent objectForKey:@"DefaultDashDirectionX"] floatValue];
        dashDirectionY = [[defaultAIComponent objectForKey:@"DefaultDashDirectionY"] floatValue];
    }
    m_dashDirection = CGPointMake(dashDirectionX, dashDirectionY);
   
    [self initEventHandler];
      
    return self;
}

-(void)update:(float)dt
{
    [m_stateMachine update];
}

-(void)initEventHandler
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enemyChangeDirection:)
                                                 name:eEnemyChangeDirection
                                               object:nil];
}

-(void)enemyChangeDirection:(NSNotification *)notification
{
    assert(m_owner);
    // update dir
    CGPoint curDir = self.m_direction;
    CGPoint newDir = CGPointMake(-curDir.x, curDir.y);
    self.m_direction = newDir;
    //update y pos
    float stepdown = self.m_stepDownDist;
    CGPoint curPos = [m_owner GetPosition];
    CGPoint fPos = CGPointMake(curPos.x, curPos.y - stepdown);
    [m_owner SetPosition:fPos];
}

@end
