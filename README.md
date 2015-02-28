# AutoLayout
Testing Autolayout constraints and subviews
 
 The storyboard has screen of following format
 
UIView
  -UIScrollView
   --UIView
     ---UIImage View
     ---UIWebView
     ---UIView (calling it moreView for easy reference.)

After the url gets loaded in webview, multiple subviews are created inside moreView of below fashion 

         ---- UIView(4)
           -----Label1
           -----Label2
        ----UIView(commentsView)
           -----TableView
        ----UI Label 
In actuall poc it will have UICollectionView after commentsView and one more TableView.

The idea is to check if more view and al subviews dynamically loaded can have dynamic height.
