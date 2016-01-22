//
//  TGRDicDataSource.m
//  Langland
//
//  Created by mai on 15/4/13.
//  Copyright (c) 2015年 langland. All rights reserved.
//

#import "TGRDicDataSource.h"

@implementation TGRDicDataSource



-(id)initWithCellReuseIdentifier:(NSString *)defaultReuseIdentifier configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock indices:(NSDictionary *)indices
{
    return [self initWithCellReuseIdentifier:defaultReuseIdentifier configureCellBlock:configureCellBlock indices:indices sectionTitleMap:@{@"#":NSLocalizedString(@"Common", nil)} sortedSectionUsingComparator:nil];
}

-(id)initWithReuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock indices:(NSDictionary *)indices
{
    return [self initWithReuseIdentifierBlock:reuseIdentifierBlock configureCellBlock:configureCellBlock indices:indices sectionTitleMap:@{@"#":NSLocalizedString(@"Common", nil)} sortedSectionUsingComparator:nil];
}


-(id)initWithCellReuseIdentifier:(NSString *)defaultReuseIdentifier configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock indices:(NSDictionary *)indices sectionTitleMap:(NSDictionary *)sectionTitleMap sortedSectionUsingComparator:(NSComparator)sectionsComparator
{
    self = [self initWithCellReuseIdentifier:defaultReuseIdentifier configureCellBlock:configureCellBlock];
    if (self) {
        self.indices = indices;
        self.sectionTitleMap = sectionTitleMap;
        self.sectionsComparator = sectionsComparator;
    }
    return self;
}

-(id)initWithReuseIdentifierBlock:(TGRDataSourceReuseIdentifierBlock)reuseIdentifierBlock configureCellBlock:(TGRDataSourceCellBlock)configureCellBlock indices:(NSDictionary *)indices sectionTitleMap:(NSDictionary *)sectionTitleMap sortedSectionUsingComparator:(NSComparator)sectionsComparator
{
    self =[self initWithReuseIdentifierBlock:reuseIdentifierBlock configureCellBlock:configureCellBlock];
    if (self) {
        self.indices = indices;
        self.sectionTitleMap = sectionTitleMap;
        self.sectionsComparator = sectionsComparator;
    }
    return self;
}

-(void)setIndices:(NSDictionary *)indices
{
    _indices = indices;
    if (self.sectionsComparator) {
        _sections = [_indices.allKeys sortedArrayUsingComparator:self.sectionsComparator];
    }else{
        _sections = [_indices.allKeys sortedArrayUsingSelector:@selector(compare:)];
    }
}


-(id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        NSString* sec = self.sections[indexPath.section];
        return self.indices[sec][indexPath.row];
    }else{
        return nil;
    }
}

-(NSIndexPath *)indexPathForItem:(id)item
{
    for (int sec = 0; sec < self.sections.count; sec++) {
        NSString* secName = self.sections[sec];
        NSArray* currSections = self.indices[secName];
        for (int row = 0; row < currSections.count; row++) {
            id currItem = currSections[row];
            if ([self item:currItem isEqualToItem:item]) {
                return [NSIndexPath indexPathForRow:row inSection:sec];
            }
        }
    }
    return nil;
}


-(BOOL)item:(id)item1 isEqualToItem:(id)item2
{
    if (self.equalBlock) {
        return self.equalBlock(item1, item2);
    }
    return [item1 isEqual:item2];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    if (self.sections.count == 0) {
        return 0;
    }

    NSString* secName = self.sections[section];
    NSArray* rows = self.indices[secName];
    return rows.count;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* rtn = self.sections[section];
    
    if (self.sectionTitleMap[rtn]) {
        return self.sectionTitleMap[rtn];
    }else{
        return rtn;
    }
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sections;
}




@end
