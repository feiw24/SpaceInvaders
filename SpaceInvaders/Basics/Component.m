//
//  Component.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/2/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Component.h"
#import "Instance.h"

@implementation Component

@synthesize m_owner, m_type, m_data;

- (id)init
{
    if (!(self = [super init])) 
        return nil;
    
    m_owner = nil;
    m_data = nil;
    
    return self;
}

- (id)initWithOwner:(Instance*)owner
{
    if (!(self = [super init])) 
        return nil;
    
    m_owner = owner;
    m_data = nil;
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    m_owner = nil;
    m_data = nil;
}

-(ComponentType) GetComponentType
{
    return m_type;
}

-(void) update:(float)dt
{

}

-(void) Destroy
{
    
}

@end
