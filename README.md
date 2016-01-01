# CountDown
### Simply implement the CountDown by UIPickerView and NSDateComponents


## My ideas
* Use the method     

	NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | 	NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
   	``NSDateComponents *comp = [calendar components:unitFlags fromDate:_standardTime toDate:_destTime options:0];``

#### By this method , I can get How much the time distance between 2 dates.frankly,this method is the point to the countdown. 
##### (look  **details into demo**)
## Picture
![image](/Users/lister/Desktop/1.png)


