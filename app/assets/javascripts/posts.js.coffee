# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
root = exports ? this
root.callbacks = {removePost: (data) -> 
                     $("#" + data["post"]["id"]).remove()
                 , displayErrorMessage: (data) ->
                     alert ["Error!", data["error"]].join " "
                 }
                 
root.sendPostDestroyRequest = (callbacks, configuration) ->
    $.ajax {
        url: configuration.url, 
        dataType: "json", 
        success: (data) -> callbacks.removePost data, 
        error: (data) -> callbacks.displayErrorMessage data, 
        timeout: configuration.remainingCallTime
    }