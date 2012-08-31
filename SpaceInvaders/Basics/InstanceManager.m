//
//  InstanceManager.m
//  SpaceInvaders
//
//  Created by Fei Wang on 8/3/12.
//  Copyright (c) 2012 Crystal Dynamics, Square Enix. All rights reserved.
//

#import "InstanceManager.h"

@implementation InstanceManager

@synthesize m_instances, m_playerInstance;

static InstanceManager *DefaultManager = nil;


+ (InstanceManager *)sharedInstanceManager {
    
    if (!DefaultManager) DefaultManager = [[self allocWithZone:NULL] init];
    
    return DefaultManager;
    
}

-(id)init
{
    if(!(self = [super init]))
        return nil;
    
    m_instances = [[NSMutableDictionary alloc] init];
    m_toInsert = [[NSMutableArray alloc] init];
    m_toRemove = [[NSMutableArray alloc] init];
    return self;
}

-(int)getNextInstanceID
{
    static int next_id = 0;
    return ++next_id;
}

-(void)registerInstance:(Instance*)instance
{
    if (updating) {
        [m_toInsert addObject: instance]; 
    }else
    {
        NSString* key = [NSString stringWithFormat:@"%i", instance.m_id];
        [m_instances setValue:instance forKey:key];
        
    }
}

-(Instance*) getInstance:(int)ID
{
    NSString* key = [NSString stringWithFormat:@"%i", ID];
    return [m_instances objectForKey:key];
}
-(bool)removeInstance:(Instance*)instance
{
    if(updating)
    {
        if(![m_toRemove containsObject:instance])
            [m_toRemove addObject: instance];
    }else{
        NSString* key = [NSString stringWithFormat:@"%i", instance.m_id];
        [m_instances removeObjectForKey:key];
        [instance Destroy];

        return true;
    }
    return false;
}


-(void)destroyAll
{
    for(id key in m_instances) {
        Instance* instance = (Instance*)[m_instances objectForKey:key];
        [instance Destroy];
    }
    [m_instances removeAllObjects];  
    for(int i = [m_toRemove count]-1; i>=0; i--)
    {
        Instance* instance = [m_toRemove objectAtIndex:i];
        [instance Destroy];
    }       
    [m_toRemove removeAllObjects];
    for(int i = [m_toInsert count]-1; i>=0; i--)
    {
        Instance* instance = [m_toInsert objectAtIndex:i];
        [instance Destroy];
    } 
    [m_toInsert removeAllObjects];
    m_playerInstance = nil;
}

-(void)update:(float)dt{
    
    //update instace components
    updating = true;
    for(id key in m_instances) 
    {
        Instance* instance = (Instance*)[m_instances objectForKey:key];
        [instance Update:dt];
    }
    updating = false;
    
    //update instance buffer
    for(int i = [m_toInsert count]-1; i>=0; i--)
    {
        Instance* instance = [m_toInsert objectAtIndex:i];
        
        [self registerInstance:instance];
        [m_toInsert removeObject:instance];
    }
   
   
    for(int i = [m_toRemove count]-1; i>=0; i--)
    {
        Instance* instance = [m_toRemove objectAtIndex:i];
        NSString* key = [NSString stringWithFormat:@"%i", instance.m_id];
        [m_instances removeObjectForKey:key];
        [m_toRemove removeObject:instance];
        [instance Destroy];
        if ([instance isEqual:m_playerInstance]) {
            m_playerInstance = nil;
        }
    }
}

-(Instance*) GetPlayer
{
    return m_playerInstance;
}

-(int) GetNumEnemies
{
    int num = 0;
    for(id key in m_instances) {
        Instance* instance = (Instance*)[m_instances objectForKey:key];
        if([instance IsEnemy])
            num++;
    }
    return num;
}

@end
