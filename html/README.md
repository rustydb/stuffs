# HTML

Check this site out with Docker!

```bash
# Run the 4lambda site using rustydb's registry
$> docker run --name www -v $(pwd)/4lambda:/var/www/html:ro -d -p 80:80 rustydb/centos:7-lamp
```
