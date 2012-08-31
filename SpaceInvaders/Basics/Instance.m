//
//  Instance.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/2/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "Instance.h"
#import "InstanceManager.h"
#import "DrawComponent.h"
#import "SceneManager.h"

@implementation Instance

@synthesize m_id, m_components;

-(id)init{
    if(!(self = [super init]))
        return nil;
    m_components = [[NSMutableDictionary alloc] init];
    m_id = [[InstanceManager sharedInstanceManager] getNextInstanceID];
    
    return self;
}

-(id)initWithID:(int) ID
{
    if(!(self = [super init]))
        return nil;
    m_id = ID;
    
    m_components = [[NSMutableDictionary alloc] init];
    return self;
}

-(void)dealloc{
    [super dealloc];
    
    [m_components removeAllObjects];
    m_components = nil;
}

-(void)Destroy
{
    for (id key in m_components) {
        Component* comp = [m_components objectForKey:key];
        [comp Destroy];
    }
    [m_components removeAllObjects];
    m_components = nil;
}

-(void)Update:(float)dt;
{
    //player component
    if([self GetComponent:eComponent_Player] )
        [[self GetComponent:eComponent_Player] update:dt];

    //ai
    if([self GetComponent:eComponent_AI] )
        [[self GetComponent:eComponent_AI] update:dt];

    //attck
    if([self GetComponent:eComponent_Attack] )
        [[self GetComponent:eComponent_Attack] update:dt];

    //projectile
    if([self GetComponent:eComponent_Projectile] )
        [[self GetComponent:eComponent_Projectile] update:dt];

    //health
    if([self GetComponent:eComponent_Health] )
        [[self GetComponent:eComponent_Health] update:dt];

    //draw
    if([self GetComponent:eComponent_Draw] )
        [[self GetComponent:eComponent_Draw] update:dt];
    
    //boundary check
    if([self OutOfBoundery])
        [[InstanceManager sharedInstanceManager] removeInstance:self];

}

-(Component*) GetComponent:(ComponentType)type
{
    NSString* key = [NSString stringWithFormat:@"%i", type];
    return [m_components objectForKey:key];
}

-(Component*) SetComponent:(Component*)component
{
    component.m_owner = self;
    NSString* key = [NSString stringWithFormat:@"%i", component.m_type];
    Component* oldComponent = [m_components objectForKey:key];
    [m_components setValue:component forKey:key];
    return oldComponent;
}

-(void) ClearComponent
{
    [m_components removeAllObjects];
    m_components = nil;
}


-(CGPoint) GetPosition
{
    if ([self GetComponent:eComponent_Draw]) {
        DrawComponent* drawComp = (DrawComponent*)[self GetComponent:eComponent_Draw];
        return [drawComp GetPosition];
    }
    return CGPointMake(0.0f, 0.0f); 
}

-(void)SetPosition:(CGPoint)pos
{
    if ([self GetComponent:eComponent_Draw]) {
        DrawComponent* drawComp = (DrawComponent*)[self GetComponent:eComponent_Draw];
        [drawComp SetPosition:pos];
    }
}

-(CGPoint) GetSize
{
    if ([self GetComponent:eComponent_Draw]) {
        DrawComponent* drawComp = (DrawComponent*)[self GetComponent:eComponent_Draw];
        return CGPointMake(drawComp.m_width, drawComp.m_height);
    }
    return CGPointMake(0.0f, 0.0f);
}

-(bool)IsEnemy
{
    if ([self GetComponent:eComponent_AI]) 
        return true;
    else {
        return false;
    }
}

-(bool)IsProjectile
{
    if([self GetComponent:eComponent_Projectile])
        return true;
    return false;
}
-(bool)IsPlayer
{
    if([self GetComponent:eComponent_Player])
        return true;
    return false;
}

-(bool)OutOfBoundery
{
    CGPoint fPos = [self GetPosition];
    CGPoint size = [self GetSize];
    if (   fPos.y < 0 - size.y/2.0f 
        || fPos.y  > SCREEN_HEIGHT+ size.y/2.0f 
        || fPos.x <0 - size.x/2.0f 
        || fPos.x > SCREEN_WIDTH + size.x/2.0f)
    {
        return YES;
    }
    return NO;
}

@end
