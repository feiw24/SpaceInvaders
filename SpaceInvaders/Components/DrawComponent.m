//
//  DrawComponent.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "DrawComponent.h"
#import "CGPointExtension.h"
#import "SceneManager.h"
#import "DataHelper.h"

@implementation DrawComponent

@synthesize m_sprite, m_width, m_height;

-(id)init
{
    if(!(self = [super init]))
        return nil;
    m_type = eComponent_Draw;
    return self;
}

-(id)initWithData:(NSDictionary*)componentData
{
    self = [self init];
    
    m_data = componentData;
    NSString* image = nil;
    if ([componentData objectForKey:@"Image"]) {
       image = [componentData objectForKey:@"Image"];
    }else {
        NSDictionary* defaultDrawComponent = [DataHelper ReadPlist:@"DrawComponent"];
        image = [defaultDrawComponent objectForKey:@"DefaultImage"];
    }
    CCSprite* sprite = [[CCSprite alloc] initWithFile:image];
    m_sprite = sprite;
    
    if ([componentData objectForKey:@"Scale"]) {
        m_sprite.scale = [[componentData objectForKey:@"Scale"] floatValue];
    }
    
    m_width = [sprite boundingBox].size.width;
    m_height = [sprite boundingBox].size.height;
    
    [[SceneManager sharedSceneManager] AddSprite:m_sprite];
    
    m_x = 0;
    m_y = 0;
    m_sprite.position = CGPointMake(m_x, m_y);
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
    
    // need to remove the sprite from cclayer here
    [[SceneManager sharedSceneManager] RemoveSpreite:m_sprite];
    
    m_sprite =nil;
}

-(void)Destroy
{
    [[SceneManager sharedSceneManager] RemoveSpreite:m_sprite];
    m_sprite =nil;

}

-(void)update:(float)dt
{
     m_sprite.position = ccp(m_x, m_y);
}

-(void)draw
{

}

-(CGPoint) GetPosition
{
    return CGPointMake(m_x, m_y);
}

-(void)SetPosition:(CGPoint)pos
{
    m_x = pos.x;
    m_y = pos.y;
}


@end
