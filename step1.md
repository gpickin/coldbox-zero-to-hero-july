## 1 - Create the base app

### 1.1 - Create a folder for your app on your hard drive called `soapbox`.
`
### 1.2  Scaffold out a new Coldbox application with TestBox included.

```sh
coldbox create app soapbox
```

### 1.2 bug Install testbox if the above command didn't work (CommandBox < 4.2)

```sh
install --dev
```


### 1.3 - Start up a local server

```sh
start cfengine=lucee@5 port=42518 --rewritesEnable
```

### 1.4 - Open `http://localhost:42518/` in your browser. You should see the default ColdBox app template.

### 1.5 - Open `/tests` in your browser. You should see the TestBox test browser.
    This is useful to find a specific test or group of tests to run _before_ running them.

### 1.6 - Open `/tests/runner.cfm` in your browser. You should see the TestBox test runner for our project.
    This is running all of our tests by default. We can create our own test runners as needed.

All your tests should be passing at this point. 😉

### 1.7 - Let's run the Tests via CommandBox

```sh
testbox run "http://localhost:42518/tests/runner.cfm"
```

### 1.7.1 - Lets add this url to our server.json

We can set the testbox runner into our server.json, and then we can easily run the tests at a later stage without having to type out the whole url. To do so, we use the `package set` command.

```sh
package set testbox.runner="http://localhost:42518/tests/runner.cfm"
testbox run
```

### 1.8 - Use CommandBox Test Watchers

CommandBox now supports Test Watchers. This allows you to automatically run your tests run as you make changes to tests or cfcs. You can start CommandBox Test watchers with the following command

```sh
testbox watch
```

You can also control what files to watch.

```sh
testbox watch **.cfc
```

`ctl-c` will escape and stop the watching.