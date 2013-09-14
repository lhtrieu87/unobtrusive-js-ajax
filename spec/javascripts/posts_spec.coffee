root = exports ? this
describe "Posts: index page", ->
    describe "post destruction", ->
       configuration = {url: "posts/3", remainingCallTime: 3000}
       
       it "should make an Ajax request to the correct URL", ->
           spyOn $, "ajax"
           sendPostDestroyRequest undefined, configuration
           expect($.ajax.mostRecentCall.args[0]["url"]).toEqual configuration.url
       
       describe "should destroy the post successfully", ->
           beforeEach ->
               loadFixtures 'posts_destroy.html'
           it "should remove the post from the view", ->
               (spyOn $, "ajax").andCallFake (e) ->
                   e.success {"post": {"id": "3"}}
               spyCallbacks = {removePost: callbacks.removePost, displayErrorMessage: jasmine.createSpy()}
               
               expect($("#3")).not.toExist()
               
               sendPostDestroyRequest spyCallbacks, configuration
               expect(spyCallbacks.displayErrorMessage).not.toHaveBeenCalled()
       
       it "should receive an Ajax error", ->
           (spyOn $, "ajax").andCallFake (e) ->
               e.error {"error": "Post 3 could not be deleted!"}
           spyOn root, 'alert'
           spyCallbacks = {removePost: jasmine.createSpy(), displayErrorMessage: callbacks.displayErrorMessage}
           sendPostDestroyRequest spyCallbacks, configuration
           expect(spyCallbacks.removePost).not.toHaveBeenCalled()
           expect(root.alert).toHaveBeenCalledWith "Error! Post 3 could not be deleted!"
