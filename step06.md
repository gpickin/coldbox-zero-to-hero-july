
## 5 - Setup the Test Harness and Base Spec

### Install `cfmigrations` as a dev dependency. 

CF Migrations is different than `commandbox-migrations`. It allows you to run the migrations from a running CFML engine and NOT CommandBox.  Usually, you can use them for testing purposes or delivering updates in your apps.  However, for today, this is a development dependency only.

```sh
install cfmigrations --saveDev
```

### Configure `tests/Application.cfc`

```js
// tests/Application.cfc
this.datasource = "soapbox";
```

### Create a `tests/resources/BaseIntegrationSpec.cfc`

```js
component extends="coldbox.system.testing.BaseTestCase" {

    property name="migrationService" inject="MigrationService@cfmigrations";

    this.loadColdBox    = true;
    this.unloadColdBox  = false;

    /**
     * Run Before all tests
     */
    function beforeAll() {
        super.beforeAll();
        // Wire up this object
        application.wirebox.autowire( this );

        // Check if migrations ran before all tests
        if ( ! request.keyExists( "migrationsRan" ) ) {
            migrationService.setMigrationsDirectory( "/root/resources/database/migrations" );
            migrationService.setDatasource( "soapbox" );
            migrationService.runAllMigrations( "down" );
            migrationService.runAllMigrations( "up" );
            request.migrationsRan = true;
        }
    }

    /**
     * This function is tagged as an around each handler.  All the integration tests we build
     * will be automatically rolledbacked
     * 
     * @aroundEach
     */
    function wrapInTransaction( spec ) {
        transaction action="begin" {
            try {
                arguments.spec.body();
            } catch ( any e ){
                rethrow;
            } finally {
                transaction action="rollback";
            }
        }
    }

}
```

Let's run the tests again!

## 6 - Intro to Models - User Service

Models are at the core of ColdBox. We could teach you how to write legacy style code, but we want to teach the `right` way from the start. We still start with creating a `User Service` that will be managing users in our SoapBox.

```bash
coldbox create model name="UserService" persistence="singleton"
```

This  will create the `UserService.cfc` in the `models` folder and a companion test in `tests/specs/unit/UserServiceTest.cfc`.

### BDD - Let's write our tests first

Open up the test `/tests/specs/unit/UserServiceTest.cfc`

```js
function run() {
    describe( "User Service", function() {
        it( "can list all users", function() {
            fail( "test not implemented yet" );
        } );
    } );
}
```

Hit the url: http://127.0.0.1:42518/tests/runner.cfm to run your tests. The test will run and fail as expected. As we use BDD we will write the real test.

### Let's write the real test - step 1

```js
    function run() {
        
        describe( "User Service", function() {
			
			it( "can be created", function(){
				expect( model ).toBeComponent();
			});

            it( "can list all users", function() {
			} );
			
        } );

    }
```

Run your tests `/tests/runner.cfm` 

### Lets create the `list()` function

Lets test the `list()` function exists

Update the `/tests/specs/integration/UserServiceTest.cfc`, adding the content to the following `it` block.

```js
it( "can list all users", function() {
    var aResults = model.list();
} );
```

Run the tests and you'll get the following error `component [models.UserService] has no function with name [list]`

Lets create the `list()` function

```js
function list(){
    return "";
}
```

Run the tests and you'll see you tests pass.

### Lets make the `list()` function return the data

Update the `/tests/specs/integration/UserServiceTest.cfc`, adding the content to the following `it` block. This will check the return type, to ensure the return is an array.

```js
it( "can list all users", function() {
    var aResults = model.list();
	expect( aResults ).toBeArray();
} );
```

Run the tests, and they will fail with the following error. `Actual data [] is not of this type: [Array]`

```js
function list(){
    return queryExecute( "select * from users", {}, { returntype = "array" } );
}
```

Run the tests, and the test should pass.
