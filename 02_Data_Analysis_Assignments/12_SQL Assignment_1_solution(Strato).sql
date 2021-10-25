insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(5,2,10,'2-12-20')
insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(1,3,15,'2-13-20')
insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(2,1,20,'2-13-20')
insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(2,3,25,'2-14-20')
insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(3,1,20,'2-15-20')
insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(3,2,15,'2-15-20')
insert into dbo.transactions
(sender,receiver,amount, transaction_date)
values(1,4,5,'2-16-20')

select * from dbo.transactions

-- Sum amounts for each sender (debits) and 
-- receiver (credits),
-- sum amounts for each sender (debits) and receiver (credits)

SELECT sender, sum(amount) AS debited
INTO debits
FROM dbo.transactions
GROUP BY sender


SELECT receiver, sum(amount) AS credited
INTO credits
FROM dbo.transactions
GROUP BY receiver

-- full (outer) join debits and credits tables on user id, taking net change as difference between credits and debits, coercing nulls to zeros with coalesce()

SELECT coalesce(sender, receiver) AS "user", 
coalesce(credited, 0) - coalesce(debited, 0) AS net_change 
FROM debits d
FULL JOIN credits c
ON d.sender = c.receiver
ORDER BY 2 DESC


