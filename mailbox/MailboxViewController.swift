//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Cameron Stewart on 10/1/15.
//  Copyright © 2015 cameronstewart. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    var containerOriginalPosition: CGPoint!
    var containerMovedPosition: CGPoint!
    var containerDefaultPosition: CGPoint!

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var messageContainerView: UIView!
    
    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var rescheduleContainerView: UIView!
    @IBOutlet weak var rescheduleView: UIImageView!
    
    @IBOutlet weak var listView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1367)
        
        containerDefaultPosition = containerView.center
        
        messageDefaultPosition = messageView.center
        
        laterIconImageView.alpha = 0
        archiveIconImageView.alpha = 0
        
        //reschedule view
        rescheduleContainerView.alpha = 0
        rescheduleContainerView.frame.origin.y = 10
        
        //list view
        listView.alpha = 0
        listView.frame.origin.y = 10
        
        laterIconViewOriginalPosition = laterIconImageView.center
        archiveIconViewOriginalPosition = archiveIconImageView.center

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var messageView: UIImageView!
    //set original location variable to cgpoint
    var messageViewOriginalPosition: CGPoint!
    
    var messageDefaultPosition: CGPoint!
    
    @IBOutlet weak var laterIconImageView: UIImageView!
    @IBOutlet weak var archiveIconImageView: UIImageView!

    var laterIconViewOriginalPosition: CGPoint!
    var archiveIconViewOriginalPosition: CGPoint!
    
    @IBAction func onMessagePanGesture(sender: UIPanGestureRecognizer) {
        
        var point = sender.locationInView(view)
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        
        //BEGAN
        if sender.state == UIGestureRecognizerState.Began{
            //began code here
            print("msg gesture begin")
            
            //set original location of view being dragged
            messageViewOriginalPosition = messageView.center
            
            //set bg to gray
            messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
        
        //CHANGED
        if sender.state == UIGestureRecognizerState.Changed{
            print("msg changing")
            
            messageView.center.x = messageViewOriginalPosition.x + translation.x
            
            //Reveal icon's opacity
            laterIconImageView.alpha = translation.x / -60
            //Reveal icon's opacity
            archiveIconImageView.alpha = translation.x / 60
            
            //GOING LEFT
            if translation.x >= -60 && translation.x < 0 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                })
            }
            
            if translation.x < -60 && translation.x > -250 {
                //bg color transition
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainerView.backgroundColor = UIColor(red: 232.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1.0)
                })
                
                //move icon with message
                laterIconImageView.image = UIImage(named: "later_icon")
                laterIconImageView.center.x = laterIconViewOriginalPosition.x + translation.x + 60
                
            }
            if translation.x <= -250 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainerView.backgroundColor = UIColor.brownColor()
                })
                
                laterIconImageView.image = UIImage(named: "list_icon")
                laterIconImageView.center.x = laterIconViewOriginalPosition.x + translation.x + 60
            }
            
            
            //GOING RIGHT
            if translation.x > 0 && translation.x <= 60 {
                messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            }
            if translation.x > 60 && translation.x <= 250 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageContainerView.backgroundColor = UIColor.greenColor()
                })
                //move icon with message
                archiveIconImageView.image = UIImage(named: "archive_icon")
                archiveIconImageView.center.x = archiveIconViewOriginalPosition.x + translation.x - 60
            }
            if translation.x > 250 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.messageContainerView.backgroundColor = UIColor.redColor()
                })
                archiveIconImageView.image = UIImage(named: "delete_icon")
                archiveIconImageView.center.x = archiveIconViewOriginalPosition.x + translation.x - 60
            }
        }
        
        //ENDED
        if sender.state == UIGestureRecognizerState.Ended{
            print("msg end")
            print("translation is \(translation.x)")
            
            //GOING LEFT
            if translation.x >= -60 && translation.x < 0 {
                messageView.center = messageDefaultPosition
                messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            }
            if translation.x < -60 && translation.x >= -250{
                print("moved 60 to the left")
                messageContainerView.backgroundColor = UIColor(red: 232.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1.0)
                
                //make sure to reveal menu and remove message and hide icon
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    //animate
                    self.messageView.center.x = -220
                    self.laterIconImageView.center.x = self.messageView.center.x + self.messageView.frame.width/2 + 20
                    }, completion: { (completed) -> Void in
                        //completed
                        
                        UIView.animateWithDuration(0.3, delay: 0, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
                            //animate revealed schedule
                            self.rescheduleContainerView.alpha = 1
                            self.rescheduleContainerView.frame.origin.y = 0
                            }, completion: { (completed) -> Void in
                                //completed
                        })
                })
                
                
            }
            if translation.x < -250 {
                print("moved 250 to the left")
                messageContainerView.backgroundColor = UIColor.brownColor()
                
                UIView.animateWithDuration(0.2, delay: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    //animate message and icon moving
                    self.messageView.center.x = -220
                    self.laterIconImageView.center.x = self.messageView.center.x + self.messageView.frame.width/2 + 20

                    }, completion: { (completed) -> Void in
                        //completed
                        
                        //SHOW LIST OPTIONS SCREEN
                        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            //animate
                            self.listView.alpha = 1
                            self.listView.frame.origin.y = 0
                            }, completion: { (completed) -> Void in
                                //completed
                        })
                })
                
            }
            
            
            //GOING RIGHT
            if translation.x > 0 && translation.x <= 60 {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    //animate
                    self.messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                    self.messageView.center = self.messageDefaultPosition
                    }, completion: { (completed) -> Void in
                        //code
                })
                
            }
            if translation.x > 60 && translation.x <= 250 {
                
                UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    //animate
                    self.messageView.center.x = 540
                    self.archiveIconImageView.center.x = self.messageView.center.x - self.messageView.frame.width/2 - 20
                    }, completion: { (completed) -> Void in
                        //completed
                        
                        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                            //animate
                            self.messageContainerView.alpha = 0
                            self.feedView.center.y = self.feedView.center.y - 86
                            self.messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                            }, completion: { (completed) -> Void in
                                //code
                                
                                //re-center mesage & icon BEFORE animation
                                self.messageView.center = self.messageDefaultPosition
                                self.archiveIconImageView.center = self.archiveIconViewOriginalPosition
                                
                                UIView.animateWithDuration(0.3, delay: 1, options: [], animations: { () -> Void in
                                    //animate here
                                    self.feedView.center.y = self.feedView.center.y + 86
                                    self.messageContainerView.alpha = 1
                                    }, completion: { (completed) -> Void in
                                        //completed
                                })
                        })
                })
                
            }
            if translation.x > 250 {
                //hide message
                
               UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                //animate
                self.messageView.center.x = 540
                self.archiveIconImageView.center.x = self.messageView.center.x - self.messageView.frame.width/2 - 20
                }, completion: { (completed) -> Void in
                    //code
                    
                    UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                        //animate
                        self.messageContainerView.alpha = 0
                        self.feedView.center.y = self.feedView.center.y - 86
                        self.messageContainerView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                        }, completion: { (completed) -> Void in
                            //code
                            
                            //re-center mesage & icon BEFORE animation
                            self.messageView.center = self.messageDefaultPosition
                            self.archiveIconImageView.center = self.archiveIconViewOriginalPosition
                            self.archiveIconImageView.image = UIImage(named: "archive_icon")
                            
                            UIView.animateWithDuration(0.3, delay: 1, options: [], animations: { () -> Void in
                                //animate here
                                self.feedView.center.y = self.feedView.center.y + 86
                                self.messageContainerView.alpha = 1
                                }, completion: { (completed) -> Void in
                                    //completed
                            })
                    })
               })
                
            }
            
        }
        
    }
    
    
    @IBAction func hideRescheduleButton(sender: AnyObject) {
        
        //hide the message container and delayed coming back on
        
        UIView.animateWithDuration(0.4, delay: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
            //animate here
            self.rescheduleContainerView.alpha = 0
            self.rescheduleContainerView.frame.origin.y = 10
            }) { (completed) -> Void in
                //complete code here
                
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    //animate here 2nd
                    self.messageContainerView.alpha = 0
                    self.feedView.center.y = self.feedView.center.y - 86
                    }, completion: { (completed) -> Void in
                        //completed code
                        
                        //re-center mesage & icon BEFORE animation
                        self.messageView.center = self.messageDefaultPosition
                        self.laterIconImageView.center = self.laterIconViewOriginalPosition
                        
                        UIView.animateWithDuration(0.3, delay: 1, options: [], animations: { () -> Void in
                            //animate here
                            self.feedView.center.y = self.feedView.center.y + 86
                            self.messageContainerView.alpha = 1
                            }, completion: { (completed) -> Void in
                                //completed
                        })
                })
        }
        
        
    }
    
    
    //SHOW LIST FUNCTION
    @IBAction func showList(sender: UITapGestureRecognizer) {
        print("Tapped!")
        
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            //animate
            self.listView.alpha = 0
            self.listView.frame.origin.y = 10
            }, completion: { (completed) -> Void in
                //completed
                
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    //animate 2nd
                    self.messageContainerView.alpha = 0
                    self.feedView.center.y = self.feedView.center.y - 86
                    }, completion: { (completed) -> Void in
                        //completed 2nd
                        
                        //re-center mesage & icon BEFORE animation
                        self.messageView.center = self.messageDefaultPosition
                        self.laterIconImageView.center = self.laterIconViewOriginalPosition
                        self.laterIconImageView.image = UIImage(named: "later_icon")
                        
                        UIView.animateWithDuration(0.3, delay: 1, options: [], animations: { () -> Void in
                            //animate here
                            self.feedView.center.y = self.feedView.center.y + 86
                            self.messageContainerView.alpha = 1
                            }, completion: { (completed) -> Void in
                                //completed
                        })
                })
        })
    }
    
    
    @IBAction func showMenu(sender: AnyObject) {
        
        if containerView.center.x == containerDefaultPosition.x {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                //animate
                self.containerView.center.x = self.containerView.frame.width + self.containerView.frame.width/2 - 35
                }, completion: { (completed) -> Void in
                    //finished
            })
        } else {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                //animate
                self.containerView.center.x = self.containerDefaultPosition.x
                }, completion: { (completed) -> Void in
                    //finished
            })
        }
        
    }
    
    
    @IBAction func onEdgeSwipe(sender: UIScreenEdgePanGestureRecognizer) {
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgeSwipe:")
        edgeGesture.edges = UIRectEdge.Left
        containerView.addGestureRecognizer(edgeGesture)
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var point = sender.locationInView(view)
                
        //started
        if sender.state == UIGestureRecognizerState.Began{
            print("SWIPED FROM EDGE")
            
            containerOriginalPosition = containerView.center
        }
        
        //changed
        if sender.state == UIGestureRecognizerState.Changed{
            containerView.center.x = containerOriginalPosition.x + translation.x
            
            print(velocity.x)
            print("translation is \(translation.x)")
            
        }
        
        //ended
        if sender.state == UIGestureRecognizerState.Ended{
            
            if translation.x >= 100 && velocity.x > 0 {
                
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    //animate
                    self.containerView.center.x = self.containerView.frame.width + self.containerView.frame.width/2 - 35
                    }, completion: { (completed) -> Void in
                        //finished
                })
                
            } else if velocity.x < 0{
                
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    //animate
                    self.containerView.center.x = self.containerDefaultPosition.x
                    }, completion: { (completed) -> Void in
                        //finished
                })
                
            } else {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [UIViewAnimationOptions.CurveEaseIn], animations: { () -> Void in
                    //animate
                    self.containerView.center.x = self.containerDefaultPosition.x
                    }, completion: { (completed) -> Void in
                        //finished
                })
            }
        }
    }
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
