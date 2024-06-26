rawgn=[
    100      69.2308
    99.7732  98.4127
    99.6154  88.0769
    97.4359  96.7033
    99.0991  92.7928
    98.5714   91.4286
    97.3545   95.2381]

 precisionawgn=sum(abs(rawgn-repmat(mean(rawgn),size(rawgn,1),1)))/size(rawgn,1);%average deviation
prcntprcision1=100-100*(precisionawgn./mean(rawgn))

rsalt=[100       92.3077    
 99.7732   95.2381   
 99.6154   95.7692
 97.4359   96.1538
 99.0991   93.6937
 98.5714   92.8571
 97.3545   95.2381]
 precisionsalt=sum(abs(rsalt-repmat(mean(rsalt),size(rawgn,1),1)))/size(rawgn,1);%average deviation
prcntprcision2=100-100*(precisionsalt./mean(rsalt))
