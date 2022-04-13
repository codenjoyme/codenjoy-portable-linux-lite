Linux portable script (simple version)
======================
This tutorial can be used to run Codenjoy server on MacOS, but you can do it only using Vagrant

How to run server on Linux?
----------------------------
Other options:
- If you want to run it on linux, you should read
[how to run the server on Ubuntu](https://github.com/codenjoyme/codenjoy-portable-linux.git#ubuntu-portable-script)
- If you want to run it on windows, you should read
[how to run the server on Windows](https://github.com/codenjoyme/codenjoy-portable-windows.git#windows-portable-script)



### Manual

If you have Docker installed on your machine, you can use the easiest way to start server.

**Be careful, you need to run everything under sudo**

```
sudo bash start.sh
```

If you want to change server settings, go to .env file and change variables, then run

```
sudo bash restart.sh
```

If you want to stop the server, then run

```
sudo bash stop.sh
```

- Go to ```http://your-server:8080/codenjoy-contest/```


That's all, enjoy

### Vagrant

If you want to, use Vagrant, you should install Vagrant-env plugin before

```
vagrant plugin install vagrant-env
```

Then, just run 

```
vagrant up 
```

If you want to change some settings manually, change .env file before.
If you've already ran Vagrant, then just do 

```
vagrant reload
```

###Advice

- Clear browser cache (old scripts can break system) or disable caching 
 (Chrome - `Ctrl+Shift+J`, Tab `Network`, set `Disable Cache` checkbox, then press `Ctrl+F5`)

