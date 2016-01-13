//
//  VC_StoryTable.m
//  ATT_Hack_2015
//
//  Created by Aaron Crawfis on 10/3/15.
//  Copyright © 2015 Aaron Crawfis. All rights reserved.
//

#import "VC_StoryTable.h"
#import "storyObject.h"
#import "VC_Story.h"

@interface VC_StoryTable ()

@end

@implementation VC_StoryTable

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.storyTable.delegate = self;
    self.storyTable.dataSource = self;
    
    [self createData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.storyList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storyCell" forIndexPath:indexPath];
    
    storyObject *story = [self.storyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = story.title;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.story = [self.storyList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        VC_Story *destinationViewController = segue.destinationViewController;
        destinationViewController.story = self.story;
    }
}


- (void) createData
{
    storyObject *story1 = [[storyObject alloc] init];
    story1.title = @"Crawfis Vacation";
    story1.text = @"Thank you for the great weekend at your cottage! The weather was great, and the hiking was incredible. The best part od the weekend was the food you reccomended. Definitely some of the best pizza I've ever had! We'll make sure to come back and visit very soon!";
    UIImage *image1 = [UIImage imageNamed:@"image1.png"];
    story1.image = [NSData dataWithData:UIImagePNGRepresentation(image1)];
    
    storyObject *story2 = [[storyObject alloc] init];
    story2.title = @"Corporate Summit";
    story2.text = @"Test";
    UIImage *image2 = [UIImage imageNamed:@"image2.png"];
    story2.image = [NSData dataWithData:UIImagePNGRepresentation(image2)];
    
    storyObject *story3 = [[storyObject alloc] init];
    story3.title = @"Romantic Getaway";
    story3.text = @"Test";
    UIImage *image3 = [UIImage imageNamed:@"image3.png"];
    story3.image = [NSData dataWithData:UIImagePNGRepresentation(image3)];
    
    NSMutableArray *storyList = [[NSMutableArray alloc] init];
    [storyList addObject:story1];
    [storyList addObject:story2];
    [storyList addObject:story3];
    
    self.storyList = [storyList copy];
    
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
