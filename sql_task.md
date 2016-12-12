```sql
SELECT group_id, COUNT(id) as sum, MIN(id) as min_id
FROM (
  SELECT *, 
    ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY id) AS rn1,
    ROW_NUMBER() OVER (ORDER BY id) AS rn2           
  FROM users) q
GROUP BY group_id, rn2 - rn1
ORDER BY MIN(id);
```
