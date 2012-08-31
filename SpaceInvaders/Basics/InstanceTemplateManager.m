//
//  InstanceTemplateManager.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/18/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "InstanceTemplateManager.h"
#import "HealthComponent.h"
#import "DrawComponent.h"
#import "AIComponent.h"
#import "AttackComponent.h"
#import "PlayerComponent.h"
#import "InstanceManager.h"
#import "EnemyStates.h"
#import "DataHelper.h"
#import "ProjectileComponent.h"

@implementation InstanceTemplateManager

@synthesize m_instanceTemplates;

static InstanceTemplateManager* m_defaultManager = nil;

+(InstanceTemplateManager*)sharedInstanceTemplateManager
{
    if (!m_defaultManager) {
        m_defaultManager = [[InstanceTemplateManager allocWithZone:NULL] init];
    }
    return m_defaultManager;
}

-(id)init
{
    if(!(self = [super init]))
        return nil;
    
    m_instanceTemplates = [[NSMutableDictionary alloc] init];

    return self;
}

-(void)dealloc
{
    [m_instanceTemplates removeAllObjects];
    m_instanceTemplates = nil;
    
    [super dealloc];
}


-(Instance*)LoadInstanceFromTemplatePath:(NSString*)templatePath
{
    if(!templatePath)
        return nil;
    
    Instance* instance = nil;
    NSDictionary* template = [m_instanceTemplates objectForKey:templatePath];
    if (template) {
        instance = [self InitInstaceFromTemplate:template];
    }else {
        
        NSDictionary* data = [DataHelper ReadPlist:templatePath];
        if (data) {
            
            [m_instanceTemplates setObject:data forKey:templatePath];
            
            template = data;
            //create instance with data
            instance =[self InitInstaceFromTemplate:template];
        }
    }
    return instance;
}

-(Instance*)InitInstaceFromTemplate:(NSDictionary*)templateData
{
    Instance* instance = [[Instance alloc]init];
    
    NSArray* components = [templateData objectForKey:@"Components"];
    for (NSDictionary* component in components) {
        NSString* componentType = [component objectForKey:@"ComponentType"];
        NSDictionary* componentData = [component objectForKey:@"ComponentData"];
        
        if([componentType isEqualToString:@"HealthComponent"])
        {
            HealthComponent* healthComponent = [[HealthComponent alloc]initWithData:componentData];
            [instance SetComponent:healthComponent];
        }else if([componentType isEqualToString:@"DrawComponent"])
        {
            DrawComponent* drawComponent = [[DrawComponent alloc] initWithData:componentData];
            [instance SetComponent:drawComponent];
        }else if([componentType isEqualToString:@"AttackComponent"])
        {
            AttackComponent* attackComponent = [[AttackComponent alloc] initWithData:componentData];
            [instance SetComponent:attackComponent];
        }else if([componentType isEqualToString:@"AIComponent"])
        {
            EnemyStates* enemyStateMachine = [[EnemyStates alloc] initWithOwner:instance];
            AIComponent* aiComponent = [[AIComponent alloc] initWithData:componentData];
            aiComponent.m_stateMachine = enemyStateMachine;
            [instance SetComponent:aiComponent];
        }else if([componentType isEqualToString:@"PlayerComponent"])
        {
            PlayerComponent* playerComponent = [[PlayerComponent alloc] initWithData: componentData];
            [instance SetComponent:playerComponent];
        }else if([componentType isEqualToString:@"ProjectileComponent"])
        {
            ProjectileComponent* projComponent = [[ProjectileComponent alloc] initWithData:componentData];
            [instance SetComponent:projComponent];
        }else {
            NSLog(@"Component type :%@ not supported", componentType);
        }
    }
    
    [[InstanceManager sharedInstanceManager] registerInstance:instance];
    return instance;
}

@end
