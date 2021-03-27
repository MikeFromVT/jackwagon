# This script is to extract what dealer was working when form the employee schedule.  It can search by date or time.
#!/bin/bash
# Hope this works...

grep -e '08:00:00 AM' 0310_Dealer_schedule | awk '{print $1, $2, $5, $6}' | cat  


