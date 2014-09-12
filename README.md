# Scheduler Module

It has 3 porpuses:

1. Start using github and contribute to open source.
2. Learn how to publish something to npm. (TODO)
3. Become something usefull?. (TODO)

Essentially it's a queue where you can push functions to be processed
at a certain interval. Actually the functions are  not called periodically
but you can enqueue many functions and they will be executed in order at a
certain rate.

## Usage:
  ```javascript
  scheduler = new Scheduler(1000); //call functions every 1sec
  scheduler.enqueue(function(){
    console.log(new Date());
  });
  scheduler.enqueue(function(){
    console.log(new Date());
  }); 
  //Now with arguments
  scheduler.enqueue([
   function(arg1,arg2){
     console.log('First argument is:' + arg1);
     console.log('Second argument is:' + arg2);
   },
   2,'hi!'])
  scheduler.start()
  ```

## Use cases

#### External API Rate Limit

Imagine you must use a certain API for many things, but the limit is imposed
to the whole API, not just per endpoint.

* Rate limit is 1 call/sec

```javascript
var scheduler = new Scheduler(1000); // 1 call each 1000ms
var api_manager = new RestrictedApiManager({user:'me',pass:'secret');

//This could be rate limited
api_manager.getData(function(data){
  console.log("Data is": data);
});
api_manager.getMoreData(function(data2){
  console.log("Data is": data2);
});
api_manager.getOtherData(function(data3){
  console.log("Data is": data3);
});

//This won't be rate limited but it is awful
var rate_limit_delay = 1000;
api_manager.getData(function(data){
  console.log("Data is": data);
  setTimeout(function(){
    api_manager.getMoreData(function(data2){
      console.log("Data is": data2);
      setTimeout( function(){
        api_manager.getOtherData(function(data3){
          console.log("Data is": data3);
        }); //getOtherData
      },rate_limit_delay);
    }); //getMoreData
  },rate_limit_delay);
}); //getData

//This looks better
var scheduler = new Scheduler(1000); // 1 call per 1000ms
scheduler.start();
printData = function(data){
  console.log("Data is:");
  console.log(data);
  
}
scheduler.enqueue(api_manager.getData,printData);
scheduler.enqueue(api_manager.getMoreData,printData);
scheduler.enqueue(api_manager.getOtherData,printData);

```

### TODO

This is just the first structure.

1. Tests
2. Validations. What happens if you enqueue something that is not a function?
3. Error handling. What happens if your function crashes?
4. Functinality to get statistics:
  1. When will a function be executed?
  2. How many elements are in the queue?
5. More funcionalities
  1. Priorities
  2. Remove enqueued function
  3. Change execution interval
  3. Change execution interval
6. NPM publish















