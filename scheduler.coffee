###
  Scheduler class. Mainly it's a queue of functions to be
  called with a certrain time interval.

  Usage:
    scheduler = new Scheduler(1000); //call functions every 1sec
    scheduler.enqueue(function(){
      console.log(new Date());
    });
    scheduler.enqueue(function(){
      console.log(new Date());
    }); 
    //Now with arguments
    scheduler.enqueue(
     function(arg1,arg2){
       console.log('First argument is:' + arg1);
       console.log('Second argument is:' + arg2);
     },
     2,'hi!')
    
    //Using a Callback
    callback = ()-> console.log "CALLBACK"
    s.enqueue ((cb)-> cb()), Callback

    scheduler.start()
###
class Scheduler
  constructor: (opts)->
    if typeof opts == 'number' # Only interval
      opts = interval: opts
    @_queue   = []
    @interval = opts.interval
    @_timer = undefined

  start: ->
    @_timer = setInterval =>
      @process_queue()
    , @interval
  stop: ->
    clearInterval @_timer if @_timer
    @_timer = undefined

  getQueue: -> @_queue
  resetQueue: -> @_queue = []
  
  enqueue: ->
    @getQueue().push arguments
    #TODO: Rise errors if element is not a function
  
  process_queue: ->
    next_elem = @getQueue().shift()
    if next_elem and typeof next_elem[0] == 'function'
      func = next_elem[0]
      func_arguments = [].slice.call next_elem, 1
      func.apply this, func_arguments
  



module.exports = Scheduler
