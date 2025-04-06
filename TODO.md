- [ ] Add navigation to gh repo. 
```bash
 git remote -v | head -n 1 | awk -F "@" '{print $2}' | awk -F " " '{print $1}' | sed 's/:/\//g' | sed 's/.git//g' | awk '{print "http://"$1}' | xargs open
 ```

- [ ] Add bracket pairing
