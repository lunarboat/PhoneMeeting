//
//  GroupDAO.m
//  PhoneMeeting
//
//  Created by lunarboat on 15/8/30.
//  Copyright (c) 2015年 lunarboat. All rights reserved.
//

#import "GroupDAO.h"

@implementation GroupDAO

+(BOOL)insertData:(Group*)group{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"INSERT INTO groups(name) VALUES(?)",group.gName];
    [db close];
    return result;
}
+(int)queryMaxId{
    int i = 0;
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return -1;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT MAX(id) FROM groups"];
    if ([rs next]) {
        i = [rs intForColumn:@"MAX(id)"];
    }
    [rs close];
    [db close];
    return i;
}
+(NSMutableArray*)queryGroup{
    NSMutableArray *groups = [[NSMutableArray alloc]init];
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return nil;
    }
    [db setShouldCacheStatements:YES];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM groups"];
    while([rs next]) {
        Group *group = [[Group alloc]init];
        group.gId = [rs intForColumn:@"id"];
        group.gName = [rs stringForColumn:@"name"];
        [groups addObject:group];
    }
    [rs close];
    [db close];
    return groups;
}
+(BOOL)deleteGroup:(Group*)group{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"DELETE FROM groups WHERE groups.id = (?)",@(group.gId)];
    [db close];
    return result;
}

+(BOOL)updateGroup:(Group*)group{
    FMDatabase *db = [DateBaseUtil sharedDateBase];
    if (![db open]) {
        [db close];
        return NO;
    }
    [db setShouldCacheStatements:YES];
    BOOL result = [db executeUpdate:@"UPDATE groups SET name = (?) WHERE id = (?)",group.gName,@(group.gId)];
    [db close];
    return result;
}

@end
